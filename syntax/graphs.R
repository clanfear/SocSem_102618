library(dplyr)
library(DiagrammeR)


create_graph() %>%
  add_node(label = "Disorder", node_aes=node_aes(width=1, height=1, x=0, y=0, shape="rectangle", color="black", fillcolor="white")) %>%
  add_node(label = "Norm\nViolation", node_aes=node_aes(width=1, height=1, x=3, y=0, shape="rectangle", color="black", fillcolor="white")) %>%
  add_node(label = "Social Control", node_aes=node_aes(width=1, height=1, x=1.5, y=-1.5, shape="rectangle", color="black", fillcolor="white")) %>%
  add_edge(from=1, to=2, rel="a", edge_aes = edge_aes(color="black", label="A")) %>%
  add_edge(from=1, to=3, rel="M", edge_aes = edge_aes(color="black", label="B")) %>%
  add_edge(from=3, to=1, rel="leading_to", edge_aes = edge_aes(color="black", label="C")) %>%
  add_edge(from=3, to=2, rel="M", edge_aes = edge_aes(color="black", label="D")) %>%
  add_edge(from=2, to=3, rel="M", edge_aes = edge_aes(color="black", label="E")) %>%
  get_global_graph_attr_info()

