require 'maneuver/search_algorithm'

module Maneuver
  class AStar < SearchAlgorithm
    def self.path(graph, from, to, cost_algorithm)
      raise "EdgeAlgorithm hueristic (param #3 => cost_algorithm) can not be nil" unless cost_algorithm
      open = [from]
      estimate = Maneuver.cost_algorithms[cost_algorithm]
      came_from = {}
      g_score = { from => 0}
      f_score = { from => g_score[from] + estimate.compute(from, to)}

      while !open.empty?
        current = self.key_with_min_value open, f_score
        return reconstruct_path(came_from, to) if current == to
        open.delete current
        current.outgoing_edges.each do |e|
          n = e.to
          t_g_score = g_score[current] + e.cost(cost_algorithm)
          if !open.include? n || t_g_score <= g_score[n]
            came_from[n] = current
            g_score[n] = t_g_score
            f_score[n] = t_g_score + estimate.compute(n, to)
            open << n unless open.include? n
          end
        end
      end
      nil
    end

    def self.key_with_min_value(set, hash)
      min_value = Float::MAX
      min_key = nil
      set.each do |k|
        m = hash[k]
        if m < min_value
          min_key = k
          min_value = m
        end
      end
      min_key
    end

    def self.reconstruct_path(came_from, current)
      path = [current]
      while came_from.key? current
        n = came_from[current]
        path.unshift n
        current = n
      end
      path
    end
  end

  add_search_algorithm :a_star, AStar
end
