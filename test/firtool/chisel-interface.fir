; Test exporting a Chisel interface to std-out.
; RUN: firtool %s --disable-output --export-chisel-interface | FileCheck %s

; Test exporting a Chisel interface to a directory.
; RUN: firtool %s --disable-output --export-chisel-interface --chisel-interface-out-dir %t
; RUN: FileCheck %s -input-file=%t/Foo.scala

; Test exporting a Chisel interface to the default directory.
; RUN: firtool %s --split-verilog --export-chisel-interface -o %t
; RUN: FileCheck %s -input-file=%t/Foo.scala

; CHECK-LABEL: // Generated by CIRCT
; CHECK-LABEL: package shelf.foo
; CHECK-LABEL: import chisel3._
; CHECK-NEXT: import chisel3.experimental._

; CHECK-LABEL: class Foo extends ExtModule {
; CHECK-NEXT:    val in = IO(Input(UInt(4.W)))
; CHECK-NEXT:    val out = IO(Output(UInt(4.W)))
; CHECK-NEXT:  }

FIRRTL version 4.0.0
circuit Foo:
  public module Foo:
    input in: UInt<4>
    output out: UInt<4>
    connect out, in
