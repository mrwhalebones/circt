// NOTE: Assertions have been autogenerated by utils/update_mlir_test_checks.py
// RUN: circt-opt -lower-std-to-handshake %s | FileCheck %s
// CHECK-LABEL:   handshake.func @affine_apply_floordiv(
// CHECK-SAME:                                          %[[VAL_0:.*]]: index,
// CHECK-SAME:                                          %[[VAL_1:.*]]: none, ...) -> (index, none) attributes {argNames = ["in0", "inCtrl"], resNames = ["out0", "outCtrl"]} {
// CHECK:           %[[VAL_2:.*]] = merge %[[VAL_0]] : index
// CHECK:           %[[VAL_3:.*]]:3 = fork [3] %[[VAL_2]] : index
// CHECK:           %[[VAL_4:.*]]:4 = fork [4] %[[VAL_1]] : none
// CHECK:           %[[VAL_5:.*]] = constant %[[VAL_4]]#2 {value = 42 : index} : index
// CHECK:           %[[VAL_6:.*]] = constant %[[VAL_4]]#1 {value = 0 : index} : index
// CHECK:           %[[VAL_7:.*]] = constant %[[VAL_4]]#0 {value = -1 : index} : index
// CHECK:           %[[VAL_8:.*]]:2 = fork [2] %[[VAL_7]] : index
// CHECK:           %[[VAL_9:.*]] = arith.cmpi slt, %[[VAL_3]]#2, %[[VAL_6]] : index
// CHECK:           %[[VAL_10:.*]]:2 = fork [2] %[[VAL_9]] : i1
// CHECK:           %[[VAL_11:.*]] = arith.subi %[[VAL_8]]#0, %[[VAL_3]]#1 : index
// CHECK:           %[[VAL_12:.*]] = std.select %[[VAL_10]]#1, %[[VAL_11]], %[[VAL_3]]#0 : index
// CHECK:           %[[VAL_13:.*]] = arith.divsi %[[VAL_12]], %[[VAL_5]] : index
// CHECK:           %[[VAL_14:.*]]:2 = fork [2] %[[VAL_13]] : index
// CHECK:           %[[VAL_15:.*]] = arith.subi %[[VAL_8]]#1, %[[VAL_14]]#1 : index
// CHECK:           %[[VAL_16:.*]] = std.select %[[VAL_10]]#0, %[[VAL_15]], %[[VAL_14]]#0 : index
// CHECK:           return %[[VAL_16]], %[[VAL_4]]#3 : index, none
// CHECK:         }
func @affine_apply_floordiv(%arg0: index) -> index {
    %c42 = arith.constant 42 : index
    %c0 = arith.constant 0 : index
    %c-1 = arith.constant -1 : index
    %0 = arith.cmpi slt, %arg0, %c0 : index
    %1 = arith.subi %c-1, %arg0 : index
    %2 = select %0, %1, %arg0 : index
    %3 = arith.divsi %2, %c42 : index
    %4 = arith.subi %c-1, %3 : index
    %5 = select %0, %4, %3 : index
    return %5 : index
  }
