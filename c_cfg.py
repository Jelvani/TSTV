from pycparser import c_parser, c_ast
import graphviz



class NodeWrapper:
    def __init__(self, node, parent=None):
        self.node = node
        self.parent = parent

    def __getattr__(self, attr):
        return getattr(self.node, attr)
    
    
    def __instancecheck__(self, cls, instance):
        return isinstance(instance, self.node)

class CFG():
    def __init__(self, filename) -> None:
        self.filename = filename
        self.cfg = graphviz.Digraph(comment='CFG')
        self.basic_blocks = []
        self.current_block = ""
        self.leaders = []


    # get source code from lineno of node
    def get_from_line(self, node):
        with open(self.filename) as fp:
            for i, line in enumerate(fp):
                if i == node.coord.line - 1:
                    return line
                
    def parse(self):
        f = open(self.filename)
        parser = c_parser.CParser()
        ast = parser.parse(f.read())
        return ast.ext[0].body
    




    def get_leaders(self, node: NodeWrapper, prev_branch=False):
        
        if node is None:
            return
        
        if isinstance(node, c_ast.Compound):
            first = True # Only the first instruction can be a leader
            for n in node.block_items:
                n = NodeWrapper(n)
                n.parent=node
                if first:
                    first=False  
                    self.get_leaders(n,prev_branch)
                else:
                    self.get_leaders(n)

        elif isinstance(node, c_ast.If):

            t = NodeWrapper(node.iftrue)
            f = NodeWrapper(node.iffalse)
            t.parent = node
            f.parent = node

            self.get_leaders(t, prev_branch=True)
            self.get_leaders(f, prev_branch=True)
        
        elif isinstance(node, c_ast.For):
            n = NodeWrapper(node.stmt)
            n.parent = node
            self.get_leaders(node.stmt,prev_branch=True)

        else:
            if prev_branch:
                self.leaders.append(node)

    # walk a leader until end of bb
    def get_bblocks(self,node):
        if node is None:
            return
        
        if isinstance(node, c_ast.Compound):
            for node in node.block_items:
                self.get_bblocks(node)
        elif isinstance(node, c_ast.If):
            t = self.get_from_line(node.cond)
            self.current_block += t
            self.basic_blocks.append(self.current_block)
            self.current_block = ""
        else:
            t = self.get_from_line(node)
            self.current_block += t



    def walker(self):
        func_body = self.parse()
        parent = None
        for node in func_body:
            parent = self.dispatcher(node, parent)
            print(parent)

    def dispatcher(self, node, parent=None, label=None):
        if node is None:
            return parent
        
        if isinstance(node, c_ast.If):
            t = self.get_from_line(node.cond)
            self.cfg.node(f"{node.coord.line}", t)
            if parent:
                self.cfg.edge(f"{parent.coord.line}", f"{node.coord.line}", label=label)
            parent = self.dispatcher(node.iftrue, node, label="True")
            self.dispatcher(node.iffalse, node, label="False")

        elif isinstance(node, c_ast.Compound):
            nodetext = ""
            for b in node.block_items:
                t = self.get_from_line(b)
                nodetext += f"{t}"
            self.cfg.node(f"{node.block_items[0].coord.line}", nodetext)
            self.cfg.edge(f"{parent.coord.line}", f"{node.block_items[0].coord.line}", label=label)
            #new parent
            return node.block_items[0]
        
        elif isinstance(node,c_ast.For):
            t = self.get_from_line(node)
            self.cfg.node(f"{node.coord.line}", t)
            self.cfg.edge(f"{parent.coord.line}", f"{node.coord.line}", label=label)
            self.dispatcher(node.stmt, node, label="True")
        
        return parent



graph = CFG("test.c")
#graph.walker()
#graph.cfg.render('cfg', view=True, format="png")

ast = graph.parse()
graph.get_leaders(ast,prev_branch=True)
for l in graph.leaders:
    l.show()
    graph.get_bblocks(l)

print(graph.basic_blocks)

# graph.cfg.render('cfg', view=True, format="png")