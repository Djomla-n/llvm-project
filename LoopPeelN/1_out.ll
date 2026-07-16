; ModuleID = '1.ll'
source_filename = "1.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@__const.main.a = private unnamed_addr constant [7 x i32] [i32 2, i32 3, i32 1, i32 -5, i32 -4, i32 3, i32 2], align 16

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca [7 x i32], align 16
  %4 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store i32 7, ptr %2, align 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 16 %3, ptr align 16 @__const.main.a, i64 28, i1 false)
  store i32 0, ptr %4, align 4
  br label %5

5:                                                ; preds = %0
  %6 = load i32, ptr %4, align 4
  %7 = add i32 %6, 0
  %8 = sext i32 %7 to i64
  %9 = getelementptr inbounds [7 x i32], ptr %3, i64 0, i64 %8
  %10 = load i32, ptr %9, align 4
  %11 = icmp slt i32 %10, 0
  br i1 %11, label %20, label %12

12:                                               ; preds = %5
  %13 = load i32, ptr %4, align 4
  %14 = add i32 %13, 0
  %15 = mul nsw i32 %14, 2
  %16 = load i32, ptr %4, align 4
  %17 = add i32 %16, 0
  %18 = sext i32 %17 to i64
  %19 = getelementptr inbounds [7 x i32], ptr %3, i64 0, i64 %18
  store i32 %15, ptr %19, align 4
  br label %25

20:                                               ; preds = %5
  %21 = load i32, ptr %4, align 4
  %22 = add i32 %21, 0
  %23 = sext i32 %22 to i64
  %24 = getelementptr inbounds [7 x i32], ptr %3, i64 0, i64 %23
  store i32 0, ptr %24, align 4
  br label %25

25:                                               ; preds = %20, %12
  br label %26

26:                                               ; preds = %25
  %27 = load i32, ptr %4, align 4
  %28 = add i32 %27, 1
  %29 = sext i32 %28 to i64
  %30 = getelementptr inbounds [7 x i32], ptr %3, i64 0, i64 %29
  %31 = load i32, ptr %30, align 4
  %32 = icmp slt i32 %31, 0
  br i1 %32, label %41, label %33

33:                                               ; preds = %26
  %34 = load i32, ptr %4, align 4
  %35 = add i32 %34, 1
  %36 = mul nsw i32 %35, 2
  %37 = load i32, ptr %4, align 4
  %38 = add i32 %37, 1
  %39 = sext i32 %38 to i64
  %40 = getelementptr inbounds [7 x i32], ptr %3, i64 0, i64 %39
  store i32 %36, ptr %40, align 4
  br label %46

41:                                               ; preds = %26
  %42 = load i32, ptr %4, align 4
  %43 = add i32 %42, 1
  %44 = sext i32 %43 to i64
  %45 = getelementptr inbounds [7 x i32], ptr %3, i64 0, i64 %44
  store i32 0, ptr %45, align 4
  br label %46

46:                                               ; preds = %41, %33
  br label %47

47:                                               ; preds = %46
  %48 = load i32, ptr %4, align 4
  %49 = add i32 %48, 2
  %50 = sext i32 %49 to i64
  %51 = getelementptr inbounds [7 x i32], ptr %3, i64 0, i64 %50
  %52 = load i32, ptr %51, align 4
  %53 = icmp slt i32 %52, 0
  br i1 %53, label %62, label %54

54:                                               ; preds = %47
  %55 = load i32, ptr %4, align 4
  %56 = add i32 %55, 2
  %57 = mul nsw i32 %56, 2
  %58 = load i32, ptr %4, align 4
  %59 = add i32 %58, 2
  %60 = sext i32 %59 to i64
  %61 = getelementptr inbounds [7 x i32], ptr %3, i64 0, i64 %60
  store i32 %57, ptr %61, align 4
  br label %67

62:                                               ; preds = %47
  %63 = load i32, ptr %4, align 4
  %64 = add i32 %63, 2
  %65 = sext i32 %64 to i64
  %66 = getelementptr inbounds [7 x i32], ptr %3, i64 0, i64 %65
  store i32 0, ptr %66, align 4
  br label %67

67:                                               ; preds = %62, %54
  br label %68

68:                                               ; preds = %67
  %69 = load i32, ptr %4, align 4
  %70 = add i32 %69, 3
  %71 = sext i32 %70 to i64
  %72 = getelementptr inbounds [7 x i32], ptr %3, i64 0, i64 %71
  %73 = load i32, ptr %72, align 4
  %74 = icmp slt i32 %73, 0
  br i1 %74, label %83, label %75

75:                                               ; preds = %68
  %76 = load i32, ptr %4, align 4
  %77 = add i32 %76, 3
  %78 = mul nsw i32 %77, 2
  %79 = load i32, ptr %4, align 4
  %80 = add i32 %79, 3
  %81 = sext i32 %80 to i64
  %82 = getelementptr inbounds [7 x i32], ptr %3, i64 0, i64 %81
  store i32 %78, ptr %82, align 4
  br label %88

83:                                               ; preds = %68
  %84 = load i32, ptr %4, align 4
  %85 = add i32 %84, 3
  %86 = sext i32 %85 to i64
  %87 = getelementptr inbounds [7 x i32], ptr %3, i64 0, i64 %86
  store i32 0, ptr %87, align 4
  br label %88

88:                                               ; preds = %83, %75
  store i32 4, ptr %4, align 4
  br label %89

89:                                               ; preds = %88, %110
  %90 = load i32, ptr %4, align 4
  %91 = load i32, ptr %2, align 4
  %92 = icmp slt i32 %90, %91
  br i1 %92, label %93, label %113

93:                                               ; preds = %89
  %94 = load i32, ptr %4, align 4
  %95 = sext i32 %94 to i64
  %96 = getelementptr inbounds [7 x i32], ptr %3, i64 0, i64 %95
  %97 = load i32, ptr %96, align 4
  %98 = icmp slt i32 %97, 0
  br i1 %98, label %99, label %103

99:                                               ; preds = %93
  %100 = load i32, ptr %4, align 4
  %101 = sext i32 %100 to i64
  %102 = getelementptr inbounds [7 x i32], ptr %3, i64 0, i64 %101
  store i32 0, ptr %102, align 4
  br label %109

103:                                              ; preds = %93
  %104 = load i32, ptr %4, align 4
  %105 = mul nsw i32 %104, 2
  %106 = load i32, ptr %4, align 4
  %107 = sext i32 %106 to i64
  %108 = getelementptr inbounds [7 x i32], ptr %3, i64 0, i64 %107
  store i32 %105, ptr %108, align 4
  br label %109

109:                                              ; preds = %103, %99
  br label %110

110:                                              ; preds = %109
  %111 = load i32, ptr %4, align 4
  %112 = add nsw i32 %111, 1
  store i32 %112, ptr %4, align 4
  br label %89, !llvm.loop !6

113:                                              ; preds = %89
  ret i32 0
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #1

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"clang version 17.0.0"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
