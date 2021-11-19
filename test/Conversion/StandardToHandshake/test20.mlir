// NOTE: Assertions have been autogenerated by utils/update_mlir_test_checks.py
// RUN: circt-opt -lower-std-to-handshake %s | FileCheck %s
// CHECK-LABEL:   handshake.func @min_reduction_tree(
// CHECK-SAME:                                       %[[VAL_0:.*]]: index,
// CHECK-SAME:                                       %[[VAL_1:.*]]: none, ...) -> none attributes {argNames = ["in0", "inCtrl"], resNames = ["outCtrl"]} {
// CHECK:           %[[VAL_2:.*]] = merge %[[VAL_0]] : index
// CHECK:           %[[VAL_3:.*]]:14 = fork [14] %[[VAL_2]] : index
// CHECK:           %[[VAL_4:.*]]:3 = fork [3] %[[VAL_1]] : none
// CHECK:           %[[VAL_5:.*]] = constant %[[VAL_4]]#1 {value = 0 : index} : index
// CHECK:           %[[VAL_6:.*]] = arith.cmpi slt, %[[VAL_3]]#12, %[[VAL_3]]#13 : index
// CHECK:           %[[VAL_7:.*]] = std.select %[[VAL_6]], %[[VAL_3]]#10, %[[VAL_3]]#11 : index
// CHECK:           %[[VAL_8:.*]]:2 = fork [2] %[[VAL_7]] : index
// CHECK:           %[[VAL_9:.*]] = arith.cmpi slt, %[[VAL_8]]#1, %[[VAL_3]]#9 : index
// CHECK:           %[[VAL_10:.*]] = std.select %[[VAL_9]], %[[VAL_8]]#0, %[[VAL_3]]#8 : index
// CHECK:           %[[VAL_11:.*]]:2 = fork [2] %[[VAL_10]] : index
// CHECK:           %[[VAL_12:.*]] = arith.cmpi slt, %[[VAL_11]]#1, %[[VAL_3]]#7 : index
// CHECK:           %[[VAL_13:.*]] = std.select %[[VAL_12]], %[[VAL_11]]#0, %[[VAL_3]]#6 : index
// CHECK:           %[[VAL_14:.*]]:2 = fork [2] %[[VAL_13]] : index
// CHECK:           %[[VAL_15:.*]] = arith.cmpi slt, %[[VAL_14]]#1, %[[VAL_3]]#5 : index
// CHECK:           %[[VAL_16:.*]] = std.select %[[VAL_15]], %[[VAL_14]]#0, %[[VAL_3]]#4 : index
// CHECK:           %[[VAL_17:.*]]:2 = fork [2] %[[VAL_16]] : index
// CHECK:           %[[VAL_18:.*]] = arith.cmpi slt, %[[VAL_17]]#1, %[[VAL_3]]#3 : index
// CHECK:           %[[VAL_19:.*]] = std.select %[[VAL_18]], %[[VAL_17]]#0, %[[VAL_3]]#2 : index
// CHECK:           %[[VAL_20:.*]]:2 = fork [2] %[[VAL_19]] : index
// CHECK:           %[[VAL_21:.*]] = arith.cmpi slt, %[[VAL_20]]#1, %[[VAL_3]]#1 : index
// CHECK:           %[[VAL_22:.*]] = std.select %[[VAL_21]], %[[VAL_20]]#0, %[[VAL_3]]#0 : index
// CHECK:           %[[VAL_23:.*]] = constant %[[VAL_4]]#0 {value = 1 : index} : index
// CHECK:           %[[VAL_24:.*]] = br %[[VAL_4]]#2 : none
// CHECK:           %[[VAL_25:.*]] = br %[[VAL_5]] : index
// CHECK:           %[[VAL_26:.*]] = br %[[VAL_22]] : index
// CHECK:           %[[VAL_27:.*]] = br %[[VAL_23]] : index
// CHECK:           %[[VAL_28:.*]] = mux %[[VAL_29:.*]]#2 {{\[}}%[[VAL_30:.*]], %[[VAL_26]]] : index, index
// CHECK:           %[[VAL_31:.*]]:2 = fork [2] %[[VAL_28]] : index
// CHECK:           %[[VAL_32:.*]] = mux %[[VAL_29]]#1 {{\[}}%[[VAL_33:.*]], %[[VAL_27]]] : index, index
// CHECK:           %[[VAL_34:.*]], %[[VAL_35:.*]] = control_merge %[[VAL_36:.*]], %[[VAL_24]] : none
// CHECK:           %[[VAL_29]]:3 = fork [3] %[[VAL_35]] : index
// CHECK:           %[[VAL_37:.*]] = mux %[[VAL_29]]#0 {{\[}}%[[VAL_38:.*]], %[[VAL_25]]] : index, index
// CHECK:           %[[VAL_39:.*]]:2 = fork [2] %[[VAL_37]] : index
// CHECK:           %[[VAL_40:.*]] = arith.cmpi slt, %[[VAL_39]]#1, %[[VAL_31]]#1 : index
// CHECK:           %[[VAL_41:.*]]:4 = fork [4] %[[VAL_40]] : i1
// CHECK:           %[[VAL_42:.*]], %[[VAL_43:.*]] = cond_br %[[VAL_41]]#3, %[[VAL_31]]#0 : index
// CHECK:           sink %[[VAL_43]] : index
// CHECK:           %[[VAL_44:.*]], %[[VAL_45:.*]] = cond_br %[[VAL_41]]#2, %[[VAL_32]] : index
// CHECK:           sink %[[VAL_45]] : index
// CHECK:           %[[VAL_46:.*]], %[[VAL_47:.*]] = cond_br %[[VAL_41]]#1, %[[VAL_34]] : none
// CHECK:           %[[VAL_48:.*]], %[[VAL_49:.*]] = cond_br %[[VAL_41]]#0, %[[VAL_39]]#0 : index
// CHECK:           sink %[[VAL_49]] : index
// CHECK:           %[[VAL_50:.*]] = merge %[[VAL_48]] : index
// CHECK:           %[[VAL_51:.*]] = merge %[[VAL_44]] : index
// CHECK:           %[[VAL_52:.*]]:2 = fork [2] %[[VAL_51]] : index
// CHECK:           %[[VAL_53:.*]] = merge %[[VAL_42]] : index
// CHECK:           %[[VAL_54:.*]], %[[VAL_55:.*]] = control_merge %[[VAL_46]] : none
// CHECK:           sink %[[VAL_55]] : index
// CHECK:           %[[VAL_56:.*]] = arith.addi %[[VAL_50]], %[[VAL_52]]#1 : index
// CHECK:           %[[VAL_33]] = br %[[VAL_52]]#0 : index
// CHECK:           %[[VAL_30]] = br %[[VAL_53]] : index
// CHECK:           %[[VAL_36]] = br %[[VAL_54]] : none
// CHECK:           %[[VAL_38]] = br %[[VAL_56]] : index
// CHECK:           %[[VAL_57:.*]], %[[VAL_58:.*]] = control_merge %[[VAL_47]] : none
// CHECK:           sink %[[VAL_58]] : index
// CHECK:           return %[[VAL_57]] : none
// CHECK:         }
  func @min_reduction_tree(%arg0: index) {
    %c0 = arith.constant 0 : index
    %0 = arith.cmpi slt, %arg0, %arg0 : index
    %1 = select %0, %arg0, %arg0 : index
    %2 = arith.cmpi slt, %1, %arg0 : index
    %3 = select %2, %1, %arg0 : index
    %4 = arith.cmpi slt, %3, %arg0 : index
    %5 = select %4, %3, %arg0 : index
    %6 = arith.cmpi slt, %5, %arg0 : index
    %7 = select %6, %5, %arg0 : index
    %8 = arith.cmpi slt, %7, %arg0 : index
    %9 = select %8, %7, %arg0 : index
    %10 = arith.cmpi slt, %9, %arg0 : index
    %11 = select %10, %9, %arg0 : index
    %c1 = arith.constant 1 : index
    br ^bb1(%c0 : index)
  ^bb1(%12: index):     // 2 preds: ^bb0, ^bb2
    %13 = arith.cmpi slt, %12, %11 : index
    cond_br %13, ^bb2, ^bb3
  ^bb2: // pred: ^bb1
    %14 = arith.addi %12, %c1 : index
    br ^bb1(%14 : index)
  ^bb3: // pred: ^bb1
    return
  }
