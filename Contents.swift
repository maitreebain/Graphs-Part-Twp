import UIKit

struct Edge {
  public var source: Int
  public var destination: Int
  public var weight: Int?
}

struct Node {
  public var value: Int
  public var weight: Int?
}

struct Graph {
  // adjacency list
  private var adjList: [[Node]]
  
  // our initializer takes in an array of [Edge] then creates a matrix of nodes
  init(edges: [Edge]) {
    // creates empty buckets e.g [[], [], [], []] based on how many edges (connnections)
    self.adjList = Array(repeating: [Node](), count: edges.count)
    
    for edge in edges {
      // create the destination node for the current edge
      let destinationNode = Node(value: edge.destination, weight: edge.weight)
      
      // append the new destination node to the source node
      adjList[edge.source].append(destinationNode)
    }
  }
  
  public mutating func addEdge(source: Int, destination: Int, weight: Int? = nil) {
    adjList[source].append(Node(value: destination, weight: weight))
    adjList[destination].append(Node(value: source, weight: weight))
  }
  
  public func printGraph() {
    for source in 0..<adjList.count {
      for edge in adjList[source] {
        print("\(source) ---> \(edge.value)", terminator: " ")
      }
      print()
    }
  }
}

/*
     0---------1
     |       / |  \
     |    /    |    \
     |  /      |    / 2
     |/        |  /
     4---------3/
*/

let edges = [
  Edge(source: 0, destination: 1),
  Edge(source: 0, destination: 4),
  
  Edge(source: 1, destination: 0),
  Edge(source: 1, destination: 2),
  Edge(source: 1, destination: 4),
  Edge(source: 1, destination: 3),
  
  Edge(source: 2, destination: 1),
  Edge(source: 2, destination: 3),
  
  Edge(source: 3, destination: 1),
  Edge(source: 3, destination: 2),
  Edge(source: 3, destination: 4),

  Edge(source: 4, destination: 0),
  Edge(source: 4, destination: 1),
  Edge(source: 4, destination: 3),
]

var graph = Graph(edges: edges)

graph.printGraph()

/*
 0 ---> 1 0 ---> 4
 1 ---> 0 1 ---> 2 1 ---> 4 1 ---> 3
 2 ---> 1 2 ---> 3
 3 ---> 1 3 ---> 2 3 ---> 4
 4 ---> 0 4 ---> 1 4 ---> 3
*/

extension Graph {
  func bfs(source: Int) {
    var visited: Set<Int> = []
    var queue = [Int]()
    visited.insert(source)
    queue.append(source)
    while !queue.isEmpty {
      let sourceIndex = queue.removeFirst()
      print("\(sourceIndex)", terminator: " ")
      for node in adjList[sourceIndex] {
        if !visited.contains(node.value) {
          queue.append(node.value)
          visited.insert(node.value)
        }
      }
    }
  }
}

graph.bfs(source: 2)

extension Graph {
  func dfs(source: Int) {
    var stack = [Int]()
    var visited: Set<Int> = []
    stack.append(source)
    visited.insert(source)
    while !stack.isEmpty {
      let source = stack.removeLast()
      print("\(source)", terminator: " ")
      for node in adjList[source] {
        if !visited.contains(node.value) {
          visited.insert(node.value)
          stack.append(node.value)
        }
      }
    }
  }
}

graph.dfs(source: 2)
