module Maneuver
  class Graph
    def initialize(edges = [])
      @nodes = []
      @edges = edges.map { |e| Edge.new e[0], e[1] }
      @edges.each do |e|
        @nodes << e.to unless @nodes.include? e.to
        @nodes << e.from unless  @nodes.include? e.from
      end
    end

    def insert_nodes(*nodes)
      nodes.each { |n| @nodes << n unless @nodes.include? n }
    end

    def insert_edges(*edges)
      edges.each do |e|
        unless has_edge e
          @edges << e
          @nodes << e.to unless @nodes.include? e.to
          @nodes << e.from unless  @nodes.include? e.from
        end
      end
    end
    
    def has_edge(edge)
      exists = false
      @edges.each { |e| break if (exists = (e.from == edge.from && 
        e.to == edge.to)) }
      exists
    end

    def path(from, to, search_algorithm, cost_algorithm = nil)
      search = Maneuver.search_algorithms[search_algorithm]
      raise "Unknown Search Algorithm: #{search_algorithm}" unless search
      search.path(from, to, cost_algorithm)
    end
  end
end