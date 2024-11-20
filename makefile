GCC=gcc-cfg
CLANG=clang-cfg

cfg-gcc:
	gcc -fdump-tree-cfg-lineno-graph test.c -o $(GCC)/a.out
	dot -Tpdf $(GCC)/a-test.c.015t.cfg.dot -o $(GCC)/cfg.pdf


cfg-clang:
	clang -S -emit-llvm -g  test.c -o $(CLANG)/src.ll
	opt -disable-output -passes=dot-cfg -cfg-dot-filename-prefix=$(CLANG)/src $(CLANG)/src.ll
	dot -Tpdf $(CLANG)/src.s7.dot -o $(CLANG)/cfg_src.pdf
	clang -S -emit-llvm -g -O3 test.c -o $(CLANG)/tgt.ll
	opt -disable-output -passes=dot-cfg -cfg-dot-filename-prefix=$(CLANG)/tgt $(CLANG)/tgt.ll
	dot -Tpdf $(CLANG)/tgt.s7.dot -o $(CLANG)/cfg_tgt.pdf

clean:
	rm $(DIR)/*w