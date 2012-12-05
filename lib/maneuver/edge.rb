module Maneuver
  class Edge
    attr_reader :from, :to

    def initialize(from, to)
      @from, @to = from, to
      from.edges << self
      to.edges << self
    end
    
    def cost(algorithm)
      ca = Maneuver.cost_algorithms[algorithm]
      raise "Unknow Cost Algorithm: #{algorithm}" unless ca
      ca._compute(@from, @to)
    end
  end
end