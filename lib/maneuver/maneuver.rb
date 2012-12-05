module Maneuver
  @@cost_algorithms = {}
  @@search_algorithms = {}

  class << self
    def add_cost_algorithm(sym, klass)
      @@cost_algorithms[sym] = klass
    end

    def cost_algorithms
      @@cost_algorithms
    end

    def add_search_algorithm(sym, klass)
      @@search_algorithms[sym] = klass
    end

    def search_algorithms
      @@search_algorithms
    end
  end
  
end