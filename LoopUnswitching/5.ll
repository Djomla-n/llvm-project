; ModuleID = '5.c'
source_filename = "5.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4   
  %2 = alloca i32, align 4   
  %3 = alloca i32, align 4   
  %4 = alloca i32, align 4   
  %5 = alloca i32, align 4   
  store i32 0, ptr %1, align 4  
  store i32 0, ptr %4, align 4  
  store i32 0, ptr %5, align 4  
  br label %6



6:                                                ; preds = %20, %0
  %7 = load i32, ptr %5, align 4  
  %8 = load i32, ptr %3, align 4  
  %9 = icmp slt i32 %7, %8  
  br i1 %9, label %10, label %23  

10:                                               ; preds = %6
  %11 = load i32, ptr %2, align 4 
  %12 = icmp sgt i32 %11, 0 
  br i1 %12, label %13, label %16 

13:                                               ; preds = %10
  %14 = load i32, ptr %4, align 4
  %15 = add nsw i32 %14, -1
  store i32 %15, ptr %4, align 4  
  br label %19 

16:                                               ; preds = %10
  %17 = load i32, ptr %4, align 4 
  %18 = add nsw i32 %17, 1  
  store i32 %18, ptr %4, align 4  
  br label %19  

19:                                               ; preds = %16, %13
  br label %20  

20:                                               ; preds = %19
  %21 = load i32, ptr %5, align 4 
  %22 = add nsw i32 %21, 1 
  store i32 %22, ptr %5, align 4  
  br label %6, !llvm.loop !6  

23:                                               ; preds = %6
  ret i32 0 
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

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
