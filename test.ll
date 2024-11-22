; ModuleID = 'test.c'
source_filename = "test.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @s7(ptr noundef %a, ptr noundef %b, ptr noundef %c, i32 noundef %n) #0 !dbg !10 {
entry:
  %a.addr = alloca ptr, align 8
  %b.addr = alloca ptr, align 8
  %c.addr = alloca ptr, align 8
  %n.addr = alloca i32, align 4
  %i = alloca i32, align 4
  store ptr %a, ptr %a.addr, align 8
    #dbg_declare(ptr %a.addr, !16, !DIExpression(), !17)
  store ptr %b, ptr %b.addr, align 8
    #dbg_declare(ptr %b.addr, !18, !DIExpression(), !19)
  store ptr %c, ptr %c.addr, align 8
    #dbg_declare(ptr %c.addr, !20, !DIExpression(), !21)
  store i32 %n, ptr %n.addr, align 4
    #dbg_declare(ptr %n.addr, !22, !DIExpression(), !23)
  %0 = load i32, ptr %n.addr, align 4, !dbg !24
  %cmp = icmp slt i32 %0, 2, !dbg !26
  br i1 %cmp, label %if.then, label %if.end, !dbg !27

if.then:                                          ; preds = %entry
  br label %for.end, !dbg !28

if.end:                                           ; preds = %entry
    #dbg_declare(ptr %i, !30, !DIExpression(), !32)
  store i32 1, ptr %i, align 4, !dbg !32
  br label %for.cond, !dbg !33

for.cond:                                         ; preds = %for.inc, %if.end
  %1 = load i32, ptr %i, align 4, !dbg !34
  %2 = load i32, ptr %n.addr, align 4, !dbg !36
  %cmp1 = icmp slt i32 %1, %2, !dbg !37
  br i1 %cmp1, label %for.body, label %for.end, !dbg !38

for.body:                                         ; preds = %for.cond
  %3 = load ptr, ptr %a.addr, align 8, !dbg !39
  %arrayidx = getelementptr inbounds i32, ptr %3, i64 0, !dbg !39
  %4 = load i32, ptr %arrayidx, align 4, !dbg !39
  %5 = load ptr, ptr %b.addr, align 8, !dbg !42
  %arrayidx2 = getelementptr inbounds i32, ptr %5, i64 0, !dbg !42
  %6 = load i32, ptr %arrayidx2, align 4, !dbg !42
  %cmp3 = icmp slt i32 %4, %6, !dbg !43
  br i1 %cmp3, label %if.then4, label %if.else, !dbg !44

if.then4:                                         ; preds = %for.body
  %7 = load ptr, ptr %c.addr, align 8, !dbg !45
  %8 = load i32, ptr %i, align 4, !dbg !47
  %idxprom = sext i32 %8 to i64, !dbg !45
  %arrayidx5 = getelementptr inbounds i32, ptr %7, i64 %idxprom, !dbg !45
  %9 = load i32, ptr %arrayidx5, align 4, !dbg !48
  %add = add nsw i32 %9, 1, !dbg !48
  store i32 %add, ptr %arrayidx5, align 4, !dbg !48
  %10 = load ptr, ptr %b.addr, align 8, !dbg !49
  %11 = load i32, ptr %i, align 4, !dbg !50
  %idxprom6 = sext i32 %11 to i64, !dbg !49
  %arrayidx7 = getelementptr inbounds i32, ptr %10, i64 %idxprom6, !dbg !49
  %12 = load i32, ptr %arrayidx7, align 4, !dbg !51
  %add8 = add nsw i32 %12, 1, !dbg !51
  store i32 %add8, ptr %arrayidx7, align 4, !dbg !51
  br label %if.end28, !dbg !52

if.else:                                          ; preds = %for.body
  %13 = load ptr, ptr %a.addr, align 8, !dbg !53
  %arrayidx9 = getelementptr inbounds i32, ptr %13, i64 1, !dbg !53
  %14 = load i32, ptr %arrayidx9, align 4, !dbg !53
  %cmp10 = icmp sgt i32 %14, 10, !dbg !55
  br i1 %cmp10, label %if.then11, label %if.else17, !dbg !56

if.then11:                                        ; preds = %if.else
  %15 = load ptr, ptr %b.addr, align 8, !dbg !57
  %16 = load i32, ptr %i, align 4, !dbg !59
  %idxprom12 = sext i32 %16 to i64, !dbg !57
  %arrayidx13 = getelementptr inbounds i32, ptr %15, i64 %idxprom12, !dbg !57
  %17 = load i32, ptr %arrayidx13, align 4, !dbg !57
  %18 = load ptr, ptr %a.addr, align 8, !dbg !60
  %19 = load i32, ptr %i, align 4, !dbg !61
  %idxprom14 = sext i32 %19 to i64, !dbg !60
  %arrayidx15 = getelementptr inbounds i32, ptr %18, i64 %idxprom14, !dbg !60
  %20 = load i32, ptr %arrayidx15, align 4, !dbg !62
  %add16 = add nsw i32 %20, %17, !dbg !62
  store i32 %add16, ptr %arrayidx15, align 4, !dbg !62
  br label %if.end27, !dbg !63

if.else17:                                        ; preds = %if.else
  %21 = load ptr, ptr %a.addr, align 8, !dbg !64
  %22 = load i32, ptr %i, align 4, !dbg !66
  %idxprom18 = sext i32 %22 to i64, !dbg !64
  %arrayidx19 = getelementptr inbounds i32, ptr %21, i64 %idxprom18, !dbg !64
  %23 = load i32, ptr %arrayidx19, align 4, !dbg !67
  %add20 = add nsw i32 %23, 1, !dbg !67
  store i32 %add20, ptr %arrayidx19, align 4, !dbg !67
  %24 = load ptr, ptr %c.addr, align 8, !dbg !68
  %25 = load i32, ptr %i, align 4, !dbg !69
  %idxprom21 = sext i32 %25 to i64, !dbg !68
  %arrayidx22 = getelementptr inbounds i32, ptr %24, i64 %idxprom21, !dbg !68
  %26 = load i32, ptr %arrayidx22, align 4, !dbg !68
  %27 = load ptr, ptr %b.addr, align 8, !dbg !70
  %28 = load i32, ptr %i, align 4, !dbg !71
  %add23 = add nsw i32 %28, 1, !dbg !72
  %idxprom24 = sext i32 %add23 to i64, !dbg !70
  %arrayidx25 = getelementptr inbounds i32, ptr %27, i64 %idxprom24, !dbg !70
  %29 = load i32, ptr %arrayidx25, align 4, !dbg !73
  %add26 = add nsw i32 %29, %26, !dbg !73
  store i32 %add26, ptr %arrayidx25, align 4, !dbg !73
  br label %if.end27

if.end27:                                         ; preds = %if.else17, %if.then11
  br label %if.end28

if.end28:                                         ; preds = %if.end27, %if.then4
  br label %for.inc, !dbg !74

for.inc:                                          ; preds = %if.end28
  %30 = load i32, ptr %i, align 4, !dbg !75
  %inc = add nsw i32 %30, 1, !dbg !75
  store i32 %inc, ptr %i, align 4, !dbg !75
  br label %for.cond, !dbg !76, !llvm.loop !77

for.end:                                          ; preds = %if.then, %for.cond
  ret void, !dbg !80
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = distinct !DICompileUnit(language: DW_LANG_C11, file: !1, producer: "clang version 20.0.0git (https://github.com/llvm/llvm-project.git b74e7792194d9a8a9ef32c7dc1ffcd205b299336)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "test.c", directory: "/home/jelvani/TSTV", checksumkind: CSK_MD5, checksum: "9b33992516660d565f5f0acdf24fa68e")
!2 = !{i32 7, !"Dwarf Version", i32 5}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = !{i32 1, !"wchar_size", i32 4}
!5 = !{i32 8, !"PIC Level", i32 2}
!6 = !{i32 7, !"PIE Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 2}
!8 = !{i32 7, !"frame-pointer", i32 2}
!9 = !{!"clang version 20.0.0git (https://github.com/llvm/llvm-project.git b74e7792194d9a8a9ef32c7dc1ffcd205b299336)"}
!10 = distinct !DISubprogram(name: "s7", scope: !1, file: !1, line: 1, type: !11, scopeLine: 1, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !15)
!11 = !DISubroutineType(types: !12)
!12 = !{null, !13, !13, !13, !14}
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!14 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!15 = !{}
!16 = !DILocalVariable(name: "a", arg: 1, scope: !10, file: !1, line: 1, type: !13)
!17 = !DILocation(line: 1, column: 15, scope: !10)
!18 = !DILocalVariable(name: "b", arg: 2, scope: !10, file: !1, line: 1, type: !13)
!19 = !DILocation(line: 1, column: 24, scope: !10)
!20 = !DILocalVariable(name: "c", arg: 3, scope: !10, file: !1, line: 1, type: !13)
!21 = !DILocation(line: 1, column: 33, scope: !10)
!22 = !DILocalVariable(name: "n", arg: 4, scope: !10, file: !1, line: 1, type: !14)
!23 = !DILocation(line: 1, column: 40, scope: !10)
!24 = !DILocation(line: 2, column: 9, scope: !25)
!25 = distinct !DILexicalBlock(scope: !10, file: !1, line: 2, column: 9)
!26 = !DILocation(line: 2, column: 11, scope: !25)
!27 = !DILocation(line: 2, column: 9, scope: !10)
!28 = !DILocation(line: 4, column: 5, scope: !29)
!29 = distinct !DILexicalBlock(scope: !25, file: !1, line: 3, column: 5)
!30 = !DILocalVariable(name: "i", scope: !31, file: !1, line: 6, type: !14)
!31 = distinct !DILexicalBlock(scope: !10, file: !1, line: 6, column: 5)
!32 = !DILocation(line: 6, column: 14, scope: !31)
!33 = !DILocation(line: 6, column: 10, scope: !31)
!34 = !DILocation(line: 6, column: 21, scope: !35)
!35 = distinct !DILexicalBlock(scope: !31, file: !1, line: 6, column: 5)
!36 = !DILocation(line: 6, column: 25, scope: !35)
!37 = !DILocation(line: 6, column: 23, scope: !35)
!38 = !DILocation(line: 6, column: 5, scope: !31)
!39 = !DILocation(line: 7, column: 12, scope: !40)
!40 = distinct !DILexicalBlock(scope: !41, file: !1, line: 7, column: 12)
!41 = distinct !DILexicalBlock(scope: !35, file: !1, line: 6, column: 33)
!42 = !DILocation(line: 7, column: 19, scope: !40)
!43 = !DILocation(line: 7, column: 17, scope: !40)
!44 = !DILocation(line: 7, column: 12, scope: !41)
!45 = !DILocation(line: 8, column: 13, scope: !46)
!46 = distinct !DILexicalBlock(scope: !40, file: !1, line: 7, column: 25)
!47 = !DILocation(line: 8, column: 15, scope: !46)
!48 = !DILocation(line: 8, column: 18, scope: !46)
!49 = !DILocation(line: 9, column: 13, scope: !46)
!50 = !DILocation(line: 9, column: 15, scope: !46)
!51 = !DILocation(line: 9, column: 18, scope: !46)
!52 = !DILocation(line: 10, column: 9, scope: !46)
!53 = !DILocation(line: 11, column: 18, scope: !54)
!54 = distinct !DILexicalBlock(scope: !40, file: !1, line: 11, column: 18)
!55 = !DILocation(line: 11, column: 23, scope: !54)
!56 = !DILocation(line: 11, column: 18, scope: !40)
!57 = !DILocation(line: 13, column: 20, scope: !58)
!58 = distinct !DILexicalBlock(scope: !54, file: !1, line: 12, column: 9)
!59 = !DILocation(line: 13, column: 22, scope: !58)
!60 = !DILocation(line: 13, column: 12, scope: !58)
!61 = !DILocation(line: 13, column: 14, scope: !58)
!62 = !DILocation(line: 13, column: 17, scope: !58)
!63 = !DILocation(line: 14, column: 9, scope: !58)
!64 = !DILocation(line: 16, column: 13, scope: !65)
!65 = distinct !DILexicalBlock(scope: !54, file: !1, line: 15, column: 14)
!66 = !DILocation(line: 16, column: 15, scope: !65)
!67 = !DILocation(line: 16, column: 18, scope: !65)
!68 = !DILocation(line: 17, column: 21, scope: !65)
!69 = !DILocation(line: 17, column: 23, scope: !65)
!70 = !DILocation(line: 17, column: 13, scope: !65)
!71 = !DILocation(line: 17, column: 15, scope: !65)
!72 = !DILocation(line: 17, column: 16, scope: !65)
!73 = !DILocation(line: 17, column: 19, scope: !65)
!74 = !DILocation(line: 19, column: 5, scope: !41)
!75 = !DILocation(line: 6, column: 29, scope: !35)
!76 = !DILocation(line: 6, column: 5, scope: !35)
!77 = distinct !{!77, !38, !78, !79}
!78 = !DILocation(line: 19, column: 5, scope: !31)
!79 = !{!"llvm.loop.mustprogress"}
!80 = !DILocation(line: 20, column: 1, scope: !10)
