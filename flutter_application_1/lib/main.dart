import 'package:flutter/material.dart';

class NodeEditor extends StatefulWidget {
  @override
  _NodeEditorState createState() => _NodeEditorState();
}

class _NodeEditorState extends State<NodeEditor> {
  List<NodeData> nodes = [];

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      boundaryMargin: EdgeInsets.all(100),
      minScale: 0.5,
      maxScale: 2.0,
      child: Stack(
        children: nodes
            .map(
              (node) => Positioned(
                left: node.x,
                top: node.y,
                child: Draggable(
                  feedback: buildNodeWidget(node),
                  childWhenDragging: Opacity(
                    opacity: 0.5,
                    child: buildNodeWidget(node),
                  ),
                  onDragEnd: (details) {
                    setState(() {
                      node.x = details.offset.dx;
                      node.y = details.offset.dy;
                    });
                  },
                  child: buildNodeWidget(node),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget buildNodeWidget(NodeData node) {
    return Container(
      width: 150,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade400, Colors.blue.shade600],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(node.icon, color: Colors.white, size: 32),
          SizedBox(height: 8),
          Text(
            node.label,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          if (node.hasSlider)
            Slider(
              value: node.value,
              onChanged: (v) => setState(() => node.value = v),
              activeColor: Colors.white,
            ),
        ],
      ),
    );
  }
}

class NodeData {
  double x, y, value;
  String label;
  IconData icon;
  bool hasSlider;

  NodeData(
    this.x,
    this.y,
    this.label,
    this.icon, {
    this.hasSlider = false,
    this.value = 0.5,
  });
}
