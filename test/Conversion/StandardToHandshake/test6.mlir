// NOTE: Assertions have been autogenerated by utils/update_mlir_test_checks.py
// RUN: circt-opt -lower-std-to-handshake %s | FileCheck %s

// CHECK:   handshake.func @ops(%[[VAL_0:.*]]: f32, %[[VAL_1:.*]]: f32, %[[VAL_2:.*]]: i32, %[[VAL_3:.*]]: i32, %[[VAL_4:.*]]: none, ...) -> (f32, i32, none) attributes {argNames = ["in0", "in1", "in2", "in3", "inCtrl"], resNames = ["out0", "out1", "outCtrl"]} {
// CHECK:           %[[VAL_5:.*]] = merge %[[VAL_0]] : f32
// CHECK:           %[[VAL_6:.*]] = merge %[[VAL_1]] : f32
// CHECK:           %[[VAL_7:.*]]:3 = fork [3] %[[VAL_6]] : f32
// CHECK:           %[[VAL_8:.*]] = merge %[[VAL_2]] : i32
// CHECK:           %[[VAL_9:.*]]:9 = fork [9] %[[VAL_8]] : i32
// CHECK:           %[[VAL_10:.*]] = merge %[[VAL_3]] : i32
// CHECK:           %[[VAL_11:.*]]:8 = fork [8] %[[VAL_10]] : i32
// CHECK:           %[[VAL_12:.*]] = arith.subf %[[VAL_5]], %[[VAL_7]]#2 : f32
// CHECK:           %[[VAL_13:.*]]:3 = fork [3] %[[VAL_12]] : f32
// CHECK:           %[[VAL_14:.*]] = arith.subi %[[VAL_9]]#8, %[[VAL_11]]#7 : i32
// CHECK:           %[[VAL_15:.*]]:2 = fork [2] %[[VAL_14]] : i32
// CHECK:           %[[VAL_16:.*]] = arith.cmpi slt, %[[VAL_9]]#7, %[[VAL_15]]#1 : i32
// CHECK:           %[[VAL_17:.*]] = arith.subi %[[VAL_9]]#6, %[[VAL_11]]#6 : i32
// CHECK:           %[[VAL_18:.*]]:2 = fork [2] %[[VAL_17]] : i32
// CHECK:           %[[VAL_19:.*]] = arith.addi %[[VAL_15]]#0, %[[VAL_18]]#1 : i32
// CHECK:           sink %[[VAL_19]] : i32
// CHECK:           %[[VAL_20:.*]] = arith.addi %[[VAL_9]]#5, %[[VAL_11]]#5 : i32
// CHECK:           sink %[[VAL_20]] : i32
// CHECK:           %[[VAL_21:.*]] = arith.remui %[[VAL_9]]#4, %[[VAL_11]]#4 : i32
// CHECK:           sink %[[VAL_21]] : i32
// CHECK:           %[[VAL_22:.*]] = std.select %[[VAL_16]], %[[VAL_9]]#3, %[[VAL_11]]#3 : i32
// CHECK:           sink %[[VAL_22]] : i32
// CHECK:           %[[VAL_23:.*]] = arith.divf %[[VAL_13]]#2, %[[VAL_7]]#1 : f32
// CHECK:           sink %[[VAL_23]] : f32
// CHECK:           %[[VAL_24:.*]] = arith.remf %[[VAL_13]]#1, %[[VAL_7]]#0 : f32
// CHECK:           sink %[[VAL_24]] : f32
// CHECK:           %[[VAL_25:.*]] = arith.andi %[[VAL_9]]#2, %[[VAL_11]]#2 : i32
// CHECK:           sink %[[VAL_25]] : i32
// CHECK:           %[[VAL_26:.*]] = arith.ori %[[VAL_9]]#1, %[[VAL_11]]#1 : i32
// CHECK:           sink %[[VAL_26]] : i32
// CHECK:           %[[VAL_27:.*]] = arith.xori %[[VAL_9]]#0, %[[VAL_11]]#0 : i32
// CHECK:           sink %[[VAL_27]] : i32
// CHECK:           return %[[VAL_13]]#0, %[[VAL_18]]#0, %[[VAL_4]] : f32, i32, none
// CHECK:         }
func @ops(f32, f32, i32, i32) -> (f32, i32) {
^bb0(%arg0: f32, %arg1: f32, %arg2: i32, %arg3: i32):
  %0 = arith.subf %arg0, %arg1: f32
  %1 = arith.subi %arg2, %arg3: i32
  %2 = arith.cmpi slt, %arg2, %1 : i32
  %4 = arith.subi %arg2, %arg3 : i32
  %5 = arith.addi %1, %4 : i32
  %6 = arith.addi %arg2, %arg3 : i32
  %7 = arith.remui %arg2, %arg3 : i32
  %8 = select %2, %arg2, %arg3 : i32
  %9 = arith.divf %0, %arg1 : f32
  %10 = arith.remf %0, %arg1 : f32
  %11 = arith.andi %arg2, %arg3 : i32
  %12 = arith.ori %arg2, %arg3 : i32
  %13 = arith.xori %arg2, %arg3 : i32
  return %0, %4 : f32, i32
}
