; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

define i64 @test_lshr(i1 %c) {
; CHECK-LABEL: @test_lshr(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    ret i64 1023
;
entry:
  br label %loop
loop:
  %iv.lshr = phi i64 [1023, %entry], [%iv.lshr.next, %loop]
  %iv.lshr.next = lshr i64 %iv.lshr, 1
  br i1 %c, label %exit, label %loop
exit:
  %res = or i64 %iv.lshr, 1023
  ret i64 %res
}

define i64 @test_add(i1 %c) {
; CHECK-LABEL: @test_add(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    ret i64 0
;
entry:
  br label %loop
loop:
  %iv = phi i64 [8, %entry], [%iv.next, %loop]
  %iv.next = add nuw i64 %iv, 4
  br i1 %c, label %exit, label %loop
exit:
  %res = and i64 %iv, 1
  ret i64 %res
}

define i64 @test_sub(i1 %c) {
; CHECK-LABEL: @test_sub(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    ret i64 0
;
entry:
  br label %loop
loop:
  %iv = phi i64 [8, %entry], [%iv.next, %loop]
  %iv.next = sub nuw i64 %iv, 4
  br i1 %c, label %exit, label %loop
exit:
  %res = and i64 %iv, 1
  ret i64 %res
}

define i64 @test_mul(i1 %c) {
; CHECK-LABEL: @test_mul(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    ret i64 0
;
entry:
  br label %loop
loop:
  %iv = phi i64 [8, %entry], [%iv.next, %loop]
  %iv.next = mul i64 %iv, 2
  br i1 %c, label %exit, label %loop
exit:
  %res = and i64 %iv, 2
  ret i64 %res
}

define i64 @test_udiv(i1 %c) {
; CHECK-LABEL: @test_udiv(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    ret i64 0
;
entry:
  br label %loop
loop:
  %iv = phi i64 [9, %entry], [%iv.next, %loop]
  %iv.next = udiv i64 %iv, 3
  br i1 %c, label %exit, label %loop
exit:
  %res = and i64 %iv, 16
  ret i64 %res
}

define i64 @test_udiv_neg(i1 %c) {
; CHECK-LABEL: @test_udiv_neg(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ 2, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[IV_NEXT]] = udiv i64 9, [[IV]]
; CHECK-NEXT:    br i1 [[C:%.*]], label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    [[RES:%.*]] = and i64 [[IV]], 4
; CHECK-NEXT:    ret i64 [[RES]]
;
entry:
  br label %loop
loop:
  %iv = phi i64 [2, %entry], [%iv.next, %loop]
  %iv.next = udiv i64 9, %iv
  br i1 %c, label %exit, label %loop
exit:
  %res = and i64 %iv, 4
  ret i64 %res
}

define i64 @test_urem(i1 %c) {
; CHECK-LABEL: @test_urem(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    ret i64 0
;
entry:
  br label %loop
loop:
  %iv = phi i64 [3, %entry], [%iv.next, %loop]
  %iv.next = urem i64 9, %iv
  br i1 %c, label %exit, label %loop
exit:
  %res = and i64 %iv, 4
  ret i64 %res
}

define i64 @test_and(i1 %c) {
; CHECK-LABEL: @test_and(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    ret i64 2047
;
entry:
  br label %loop
loop:
  %iv = phi i64 [1025, %entry], [%iv.next, %loop]
  %iv.next = and i64 %iv, 1024
  br i1 %c, label %exit, label %loop
exit:
  %res = or i64 %iv, 1023
  ret i64 %res
}

define i64 @test_or(i1 %c) {
; CHECK-LABEL: @test_or(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    ret i64 2047
;
entry:
  br label %loop
loop:
  %iv = phi i64 [1025, %entry], [%iv.next, %loop]
  %iv.next = or i64 %iv, 1024
  br i1 %c, label %exit, label %loop
exit:
  %res = or i64 %iv, 1023
  ret i64 %res
}

define i64 @test_ashr_zeros(i1 %c) {
; CHECK-LABEL: @test_ashr_zeros(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    ret i64 1023
;
entry:
  br label %loop
loop:
  %iv.ashr = phi i64 [1023, %entry], [%iv.ashr.next, %loop]
  %iv.ashr.next = ashr i64 %iv.ashr, 1
  br i1 %c, label %exit, label %loop
exit:
  %res = or i64 %iv.ashr, 1023
  ret i64 %res
}

define i64 @test_ashr_ones(i1 %c) {
; CHECK-LABEL: @test_ashr_ones(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    ret i64 -1
;
entry:
  br label %loop
loop:
  %iv.ashr = phi i64 [-1023, %entry], [%iv.ashr.next, %loop]
  %iv.ashr.next = ashr i64 %iv.ashr, 1
  br i1 %c, label %exit, label %loop
exit:
  %res = or i64 %iv.ashr, 1023
  ret i64 %res
}

; Same as previous, but swapped operands to phi
define i64 @test_ashr_ones2(i1 %c) {
; CHECK-LABEL: @test_ashr_ones2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    ret i64 -1
;
entry:
  br label %loop
loop:
  %iv.ashr = phi i64 [%iv.ashr.next, %loop], [-1023, %entry]
  %iv.ashr.next = ashr i64 %iv.ashr, 1
  br i1 %c, label %exit, label %loop
exit:
  %res = or i64 %iv.ashr, 1023
  ret i64 %res
}


; negative case for when start is unknown
define i64 @test_ashr_unknown(i1 %c, i64 %start) {
; CHECK-LABEL: @test_ashr_unknown(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV_ASHR:%.*]] = phi i64 [ [[START:%.*]], [[ENTRY:%.*]] ], [ [[IV_ASHR_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[IV_ASHR_NEXT]] = ashr i64 [[IV_ASHR]], 1
; CHECK-NEXT:    br i1 [[C:%.*]], label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    [[RES:%.*]] = or i64 [[IV_ASHR]], 1023
; CHECK-NEXT:    ret i64 [[RES]]
;
entry:
  br label %loop
loop:
  %iv.ashr = phi i64 [%start, %entry], [%iv.ashr.next, %loop]
  %iv.ashr.next = ashr i64 %iv.ashr, 1
  br i1 %c, label %exit, label %loop
exit:
  %res = or i64 %iv.ashr, 1023
  ret i64 %res
}

; Negative case where we don't have a (shift) recurrence because the operands
; of the ashr are swapped.  (This does end up being a divide recurrence.)
define i64 @test_ashr_wrong_op(i1 %c, i64 %start) {
; CHECK-LABEL: @test_ashr_wrong_op(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV_ASHR:%.*]] = phi i64 [ [[START:%.*]], [[ENTRY:%.*]] ], [ [[IV_ASHR_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[IV_ASHR_NEXT]] = lshr i64 1, [[IV_ASHR]]
; CHECK-NEXT:    br i1 [[C:%.*]], label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    [[RES:%.*]] = or i64 [[IV_ASHR]], 1023
; CHECK-NEXT:    ret i64 [[RES]]
;
entry:
  br label %loop
loop:
  %iv.ashr = phi i64 [%start, %entry], [%iv.ashr.next, %loop]
  %iv.ashr.next = ashr i64 1, %iv.ashr
  br i1 %c, label %exit, label %loop
exit:
  %res = or i64 %iv.ashr, 1023
  ret i64 %res
}


define i64 @test_shl(i1 %c) {
; CHECK-LABEL: @test_shl(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    ret i64 0
;
entry:
  br label %loop
loop:
  %iv.shl = phi i64 [8, %entry], [%iv.shl.next, %loop]
  %iv.shl.next = shl i64 %iv.shl, 1
  br i1 %c, label %exit, label %loop
exit:
  %res = and i64 %iv.shl, 7
  ret i64 %res
}
