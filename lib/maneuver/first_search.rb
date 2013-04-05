require 'maneuver/search_algorithm'

module Maneuver

  class FirstSearch < SearchAlgorithm
    def self.prep_node
      Maneuver::Node.send :define_method, :_fs_parent, lambda { instance_variable_get :@_fs_parent }
      Maneuver::Node.send :define_method, :_fs_parent=, lambda {|a| instance_variable_set(:@_fs_parent, a)}
    end

    def self.clean_node
      Maneuver::Node.send :remove_method, :_fs_parent
      Maneuver::Node.send :remove_method, :_fs_parent=
    end

    def self.reconstruct_path(node)
      path = [node]
      while node._fs_parent
        path.unshift node._fs_parent
        node = node._fs_parent
      end
      self.clean_node
      path
    end

    def self.get_node(nodes_to_check)
      nil
    end

    def self.path(graph, from, to, edge_algorithm = nil)
      return from if from == to
      self.prep_node
      nodes_to_check = []
      visited = [from]
      from.outgoing_edges.each do |edge|
        if graph.edges.include? edge 
          edge.to._fs_parent = from;
          nodes_to_check << edge.to
        end
      end
      while !nodes_to_check.empty?
        node = self.get_node nodes_to_check
        return self.reconstruct_path(to) if node == to
        node.outgoing_edges.each do |e|
          if graph.edges.include? e
            test = e.to
            unless visited.include? test
              test._fs_parent = node
              visited << test
              nodes_to_check.unshift test
            end
          end
        end
      end
      self.clean_node
      nil
    end
  end

  class DFS < FirstSearch
    def self.get_node(nodes_to_check)
      nodes_to_check.shift
    end
  end

  class BFS < FirstSearch
    def self.get_node(nodes_to_check)
      nodes_to_check.pop
    end
  end

  [[:bfs, BFS], [:dfs, DFS]].each { |alg| add_search_algorithm alg[0], alg[1]}
end