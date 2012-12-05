module Maneuver
  class Node
    attr_reader :edges
    def initialize(*args)
      @edges = []
    end

    def outgoing_edges
      @edges.reject { |e| e.to == self }
    end

    def incoming_edges
      @edges.reject { |e| e.from == self }
    end

    def out_degree
      outgoing_edges.length
    end

    def in_degree
      incoming_edges.length
    end
  end
end