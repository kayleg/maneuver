# Maneuver is a simple and flexible path planning library.

The built-in search algorithms include:
  * Depth-First-Search
  * Breadth-First-Search
  * A\*

## Example

```
class 2DNode < Maneuver::Node
  attr_accessor :x, :y
  def initailize(id, x, y)
    super(id)
    @x, @y = x, y
  end
end

n1 = 2DNode.new(1, 0, 0)
n2 = 2DNode.new(2, 1, 3)
n3 = 2DNode.new(3, 4, 5)
n4 = 2DNode.new(4, 3, 2)
```

To build a graph you can pass in array of *edges*
```
graph = Maneuver::Graph.new [[n1, n2], [n2, n3], [n1, n4]]

path = graph.path(n1, n4, :bfs) # from, to, method
```

## Adding a new search algorithm

Create a class extending from the Maneuver::SearchAlgorithm base and implement
a self.path method.
```
class MyAlgo < Maneuver::SearchAlgorithm
  def self.path(graph, from, to, edge_cost_algorithm)
    # Implement search
  end
end
```

Then tell maneuver how it will be referenced
```
Maneuver.add_search_algorithm :my_algo, MyAlgo
```
Now you can just call
```
path = graph.path(n1, n4, :my_algo)
```

## Edge weighting

To add a weighting algorithm, extend from Maneuver::CostAlgorithm and implement
self.compute method. Costs are memoized for a given pair of nodes, as a
result Maneuver doesn't support changing a node's attributes.

```
class Manhattan < Maneuver::CostAlgorithm
  def self.compute(from, to)
    (to.x - from.x) * (to.x-from.x) + (to.y - from.y) * (to.y - from.y)
  end
end
```

Then tell maneuver how it will be referenced
```
Maneuver.add_cost_algorithm :manhattan, Manhattan
```
Now you can just call
```
path = graph.path(n1, n4, :a_star, :manhattan)
```
And you get A\* using Manhattan distance

