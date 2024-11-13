from pycparser import c_parser, c_ast
import graphviz



class CFG():
    def __init__(self, filename) -> None:
        self.filename = filename
        self.cfg = graphviz.Digraph(comment='CFG')
        self.basic_blocks = []
        self.current_block = ""


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
        return ast.ext[0].bod
    

    # returns list of nodes that are "leaders" of basic blocks
    def get_leaders(self, topnode):
        



    def get_basic_blocks(self, node, inbranch=False):
        if node is None:
            return
        
        if isinstance(node, c_ast.Compound):
            for node in node.block_items:
                t = self.get_from_line(node)
                self.get_basic_blocks(node)

            # if in current if stmt, we change control flow at end of statement list
            if inbranch:
                self.cfg.node(f"{node.coord.line}", self.current_block)
                self.basic_blocks.append(self.current_block)
                self.current_block = ""

        elif isinstance(node, c_ast.If):
            t = self.get_from_line(node)
            self.current_block += t
            self.basic_blocks.append(self.current_block)
            self.current_block = ""
            self.get_basic_blocks(node.iftrue, inbranch=True)
            self.get_basic_blocks(node.iffalse, inbranch=True)
        
        elif isinstance(node, c_ast.For):
            t = self.get_from_line(node)
            self.current_block += t
            self.basic_blocks.append(self.current_block)
            self.current_block = ""
            self.get_basic_blocks(node.stmt)

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
graph.get_basic_blocks(ast)
print(graph.basic_blocks)
graph.cfg.render('cfg', view=True, format="png")