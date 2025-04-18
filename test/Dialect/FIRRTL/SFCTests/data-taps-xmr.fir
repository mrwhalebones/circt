; RUN: firtool --verilog %s --split-input-file | FileCheck %s

FIRRTL version 4.0.0
circuit Top : %[[
  {
    "class": "sifive.enterprise.grandcentral.DataTapsAnnotation",
    "keys": [
      {
        "class": "sifive.enterprise.grandcentral.ReferenceDataTapKey",
        "source": "~Top|Top/foo:Foo/b:Bar>inv",
        "sink": "~Top|Top>tap"
      },
      {
        "class":"sifive.enterprise.grandcentral.DataTapModuleSignalKey",
        "module":"~Top|BlackBox",
        "internalPath":"random.something",
        "sink": "~Top|Top>tap2"
      },
      {
        "class":"sifive.enterprise.grandcentral.DataTapModuleSignalKey",
        "module":"~Top|BlackBox",
        "internalPath":"random.something_else",
        "sink": "~Top|Top>tap3"
      },
      {
        "class":"sifive.enterprise.grandcentral.DataTapModuleSignalKey",
        "module":"~Top|InternalPathChild",
        "internalPath":"io_out",
        "sink": "~Top|Top/unsigned:ChildWrapper/signed:Child>tap"
      }
    ]
  },
  {
    "class": "firrtl.transforms.DontTouchAnnotation",
    "target": "~Top|Top>tap"
  },
  {
    "class": "firrtl.transforms.DontTouchAnnotation",
    "target": "~Top|Top>tap2"
  },
  {
    "class": "firrtl.transforms.DontTouchAnnotation",
    "target": "~Top|Top>tap3"
  },
  {
    "class": "firrtl.transforms.DontTouchAnnotation",
    "target": "~Top|Child>tap"
  },
  {
    "class": "firrtl.transforms.DontTouchAnnotation",
    "target": "~Top|Bar>inv"
  }
]]
  module InternalPathChild :

    skip

  extmodule BlackBox :
    output existing : Probe<{a: UInt<5>, b: UInt<5>}[3]>
    defname = BlackBox

  module Child :

    inst localparam of BlackBox

    wire tap : UInt<1>
    invalidate tap

  module ChildWrapper :

    inst signed of Child

  module Bar :

    wire inv : UInt<2>
    invalidate inv

  module Foo :

    inst b of Bar

  public module Top:

    inst foo of Foo

    wire tap : UInt<2>
    invalidate tap

    wire tap2 : UInt<4>
    invalidate tap2

    wire tap3 : UInt<5>
    invalidate tap3

    inst unsigned of ChildWrapper

    inst int of InternalPathChild

; CHECK-LABEL: module Child(
; CHECK-NOT:   endmodule
; CHECK:         input [[Child_boredPort:[a-zA-Z0-9_]+]]
; CHECK:         wire tap = [[Child_boredPort]];
; CHECK:       endmodule

; CHECK-LABEL: module ChildWrapper(
; CHECK-NOT:   endmodule
; CHECK:         input [[ChildWrapper_boredPort:[a-zA-Z0-9_]+]]
; CHECK:         Child signed_0 (
; CHECK-NEXT:      .[[Child_boredPort]] ([[ChildWrapper_boredPort]])
; CHECK:       endmodule

; CHECK-LABEL: module Top(
; CHECK-NOT:   endmodule
; CHECK:         tap = Top.foo.b.inv_probe;
; CHECK-NEXT:    tap2 = Top.unsigned_0.signed_0.localparam_0.random.something;
; CHECK-NEXT:    tap3 = Top.unsigned_0.signed_0.localparam_0.random.something_else;
; CHECK:         ChildWrapper unsigned_0 (
; CHECK-NEXT:      .[[ChildWrapper_boredPort]] (Top.int_0.io_out)
; CHECK:       endmodule

; // -----

; XMR references should work through 'when's.
; https://github.com/llvm/circt/issues/4334
FIRRTL version 4.0.0
circuit Top : %[[
  {
    "class":"sifive.enterprise.grandcentral.DataTapsAnnotation",
    "keys":[
      {
        "class":"sifive.enterprise.grandcentral.ReferenceDataTapKey",
        "source":"~Top|Top>val",
        "sink":"~Top|Top/mid:Middle/leaf:Leaf>tap"
      },
      {
        "class":"sifive.enterprise.grandcentral.ReferenceDataTapKey",
        "source":"~Top|Top/mid:Middle/leaf:Leaf>val",
        "sink":"~Top|Top>tap"
      }
    ]
  }
]]
  module Leaf :
    input c: UInt<1>

    when c:
      wire val : UInt<3>
      connect val, UInt(2)

      ; Tap Top's val
      wire tap : UInt<4>
      invalidate tap

  module Middle :
    input c: UInt<1>

    when c:
      inst leaf of Leaf
      connect leaf.c, c

  ; CHECK-LABEL: module Top(
  ; CHECK-NEXT:    input c
  ; CHECK-NEXT:    output [2:0] o
  ; CHECK-NEXT:  );
  ; CHECK-EMPTY:
  ; CHECK-NEXT:    assign o = 3'h2;
  ; CHECK-NEXT:  endmodule
  public module Top :
    input c: UInt<1>
    output o: UInt<3>

    wire val : UInt<3>
    connect val, UInt(1)

    inst mid of Middle
    connect mid.c, c

    invalidate o

    ; Tap Leaf's val
    when c:
      wire tap : UInt
      invalidate tap
      connect o, tap
