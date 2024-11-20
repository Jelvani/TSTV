import pydot
import re


def parse_dbg(metadata: str):
    lineno = re.search("line: (\d+)*", metadata)
    colno = re.search("column: (\d+)*", metadata)
    return int(lineno.group(1)), int(colno.group(1))


(G1,) = pydot.graph_from_dot_file('clang-cfg/src.s7.dot')
(G2,) = pydot.graph_from_dot_file('clang-cfg/tgt.s7.dot')


for n in G2.get_nodes():
    G1.add_node(n)
    #(n.get_label())
for e in G2.get_edges():
    G1.add_edge(e)




l1 = G1.get_nodes()[1]
l2 = G2.get_nodes()[0]
e = pydot.Edge(l1, l2)
e.set_color("blue")
G1.add_edge(e)

G1.write_png('cfg.png')

print(parse_dbg("!56 = !DILocation(line: 6, column: 29, scope: !29)"))