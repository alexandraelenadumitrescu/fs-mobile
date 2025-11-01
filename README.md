//noduri
FlowChart(
  nodes: nodes,
  onNodeMoved: (node) {
    // trimit planul catre be
    sendToBackend(jsonEncode(nodes));
  }
)

//new
import 'package:flutter/material.dart';
import 'package:graphview/graphview.dart';

class NodeEditor extends StatefulWidget {
  @override
  _NodeEditorState createState() => _NodeEditorState();
}

class _NodeEditorState extends State<NodeEditor> {
  Graph graph = Graph();
  
  @override
  void initState() {
    // Adaugă noduri
    final node1 = Node.Id(1);
    final node2 = Node.Id(2);
    graph.addEdge(node1, node2);
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      child: GraphView(
        graph: graph,
        algorithm: FruchtermanReingoldAlgorithm(),
        builder: (Node node) {
          return buildNodeWidget(node);
        },
      ),
    );
  }
  
  Widget buildNodeWidget(Node node) {
    return GestureDetector(
      onTap: () => print('Node tapped: ${node.key}'),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text('Node ${node.key}'),
      ),
    );
  }
}
