//noduri
FlowChart(
  nodes: nodes,
  onNodeMoved: (node) {
    // trimit planul catre be
    sendToBackend(jsonEncode(nodes));
  }
)
