; ModuleID = 'test.ll'
source_filename = "test.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [13 x i8] c"Suma je: %d\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store i32 0, ptr %2, align 4
  store i32 5, ptr %3, align 4
  br label %.peel

.peel:                                            ; preds = %0
  %4 = load i32, ptr %3, align 4
  %5 = icmp slt i32 5, 10
  br i1 %5, label %.peel1, label %32

.peel1:                                           ; preds = %.peel
  %6 = load i32, ptr %3, align 4
  %7 = icmp eq i32 5, 5
  br i1 %7, label %.peel3, label %.peel2

.peel2:                                           ; preds = %.peel1
  %8 = load i32, ptr %3, align 4
  %9 = load i32, ptr %2, align 4
  %10 = add nsw i32 %9, 5
  store i32 %10, ptr %2, align 4
  br label %.peel4

.peel3:                                           ; preds = %.peel1
  %11 = load i32, ptr %2, align 4
  %12 = add nsw i32 %11, 100
  store i32 %12, ptr %2, align 4
  br label %.peel4

.peel4:                                           ; preds = %.peel3, %.peel2
  br label %.peel5

.peel5:                                           ; preds = %.peel4
  %13 = load i32, ptr %3, align 4
  %14 = add nsw i32 5, 1
  store i32 %14, ptr %3, align 4
  br label %15, !llvm.loop !6

15:                                               ; preds = %.peel5, %29
  %16 = load i32, ptr %3, align 4
  %17 = icmp slt i32 %16, 10
  br i1 %17, label %18, label %32

18:                                               ; preds = %15
  %19 = load i32, ptr %3, align 4
  %20 = icmp eq i32 %19, 5
  br i1 %20, label %21, label %24

21:                                               ; preds = %18
  %22 = load i32, ptr %2, align 4
  %23 = add nsw i32 %22, 100
  store i32 %23, ptr %2, align 4
  br label %28

24:                                               ; preds = %18
  %25 = load i32, ptr %3, align 4
  %26 = load i32, ptr %2, align 4
  %27 = add nsw i32 %26, %25
  store i32 %27, ptr %2, align 4
  br label %28

28:                                               ; preds = %24, %21
  br label %29

29:                                               ; preds = %28
  %30 = load i32, ptr %3, align 4
  %31 = add nsw i32 %30, 1
  store i32 %31, ptr %3, align 4
  br label %15, !llvm.loop !6

32:                                               ; preds = %.peel, %15
  %33 = load i32, ptr %2, align 4
  %34 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %33)
  ret i32 0
}

declare i32 @printf(ptr noundef, ...) #1

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

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
