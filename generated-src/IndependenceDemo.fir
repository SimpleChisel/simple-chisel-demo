circuit IndependenceDemo :
  module DecoupledIODemo_1 :
    input clock : Clock
    input reset : Reset
    output ctrl : { in : { flip valid : UInt<1>, ready : UInt<1>}, flip out : { flip valid : UInt<1>, ready : UInt<1>}, flip clear : UInt<1>}
    output in : { flip data : UInt<8>}
    input out : { flip data : UInt<8>}
  
    wire n_reg : UInt<8> @[Independence.scala 16:21]
    reg reg : UInt, clock with :
      reset => (UInt<1>("h0"), reg) @[Independence.scala 17:22]
    reg <= n_reg @[Independence.scala 17:22]
    ctrl.in.ready <= UInt<1>("h1") @[Independence.scala 19:19]
    node _T = mux(ctrl.in.valid, in.data, UInt<1>("h0")) @[Independence.scala 20:17]
    n_reg <= _T @[Independence.scala 20:11]
    ctrl.out.valid <= UInt<1>("h1") @[Independence.scala 21:20]
    out.data <= reg @[Independence.scala 22:14]

  module DecoupledIODemo_2 :
    input clock : Clock
    input reset : Reset
    output ctrl : { in : { flip valid : UInt<1>, ready : UInt<1>}, flip out : { flip valid : UInt<1>, ready : UInt<1>}, flip clear : UInt<1>}
    output in : { flip data : UInt<8>}
    input out : { flip data : UInt<8>}
  
    wire n_reg : UInt<8> @[Independence.scala 30:21]
    reg reg : UInt, clock with :
      reset => (UInt<1>("h0"), reg) @[Independence.scala 31:22]
    reg <= n_reg @[Independence.scala 31:22]
    ctrl.in.ready <= ctrl.in.valid @[Independence.scala 33:19]
    node _T = mux(ctrl.in.valid, in.data, UInt<1>("h0")) @[Independence.scala 34:17]
    n_reg <= _T @[Independence.scala 34:11]
    ctrl.out.valid <= UInt<1>("h1") @[Independence.scala 35:20]
    out.data <= reg @[Independence.scala 36:14]

  module DecoupledIODemo_3 :
    input clock : Clock
    input reset : Reset
    output ctrl : { in : { flip valid : UInt<1>, ready : UInt<1>}, flip out : { flip valid : UInt<1>, ready : UInt<1>}, flip clear : UInt<1>}
    output in : { flip data : UInt<8>}
    input out : { flip data : UInt<8>}
  
    wire n_reg : UInt<8> @[Independence.scala 45:21]
    reg reg : UInt, clock with :
      reset => (UInt<1>("h0"), reg) @[Independence.scala 46:22]
    reg <= n_reg @[Independence.scala 46:22]
    ctrl.in.ready <= UInt<1>("h1") @[Independence.scala 48:19]
    node _T = mux(ctrl.in.valid, in.data, UInt<1>("h0")) @[Independence.scala 49:17]
    n_reg <= _T @[Independence.scala 49:11]
    ctrl.out.valid <= ctrl.out.ready @[Independence.scala 50:20]
    out.data <= reg @[Independence.scala 51:14]

  module DecoupledIODemo_4 :
    input clock : Clock
    input reset : Reset
    output ctrl : { in : { flip valid : UInt<1>, ready : UInt<1>}, flip out : { flip valid : UInt<1>, ready : UInt<1>}, flip clear : UInt<1>}
    output in : { flip data : UInt<8>}
    input out : { flip data : UInt<8>}
  
    wire n_reg : UInt<8> @[Independence.scala 59:21]
    reg reg : UInt, clock with :
      reset => (UInt<1>("h0"), reg) @[Independence.scala 60:22]
    reg <= n_reg @[Independence.scala 60:22]
    node _T = add(in.data, UInt<1>("h1")) @[Independence.scala 63:38]
    node _T_1 = tail(_T, 1) @[Independence.scala 63:38]
    node next = mux(ctrl.in.valid, _T_1, UInt<1>("h0")) @[Independence.scala 63:19]
    ctrl.in.ready <= ctrl.out.ready @[Independence.scala 65:19]
    n_reg <= next @[Independence.scala 66:11]
    ctrl.out.valid <= UInt<1>("h1") @[Independence.scala 67:20]
    out.data <= reg @[Independence.scala 68:14]

  module DecoupledIODemo_5 :
    input clock : Clock
    input reset : Reset
    output ctrl : { in : { flip valid : UInt<1>, ready : UInt<1>}, flip out : { flip valid : UInt<1>, ready : UInt<1>}, flip clear : UInt<1>}
    output in : { flip data : UInt<8>}
    input out : { flip data : UInt<8>}
  
    wire n_reg : UInt<8> @[Independence.scala 76:21]
    reg reg : UInt, clock with :
      reset => (UInt<1>("h0"), reg) @[Independence.scala 77:22]
    reg <= n_reg @[Independence.scala 77:22]
    node _T = eq(ctrl.in.valid, UInt<1>("h0")) @[Independence.scala 80:24]
    when _T : @[Independence.scala 80:36]
      ctrl.in.ready <= UInt<1>("h0") @[Independence.scala 81:23]
      skip
    else :
      node _T_1 = eq(ctrl.in.valid, UInt<1>("h1")) @[Independence.scala 83:29]
      when _T_1 : @[Independence.scala 83:40]
        ctrl.in.ready <= UInt<1>("h1") @[Independence.scala 84:23]
        skip
      else :
        ctrl.in.ready <= UInt<1>("h1") @[Independence.scala 86:23]
        skip
    node _T_2 = add(in.data, UInt<1>("h1")) @[Independence.scala 88:41]
    node _T_3 = tail(_T_2, 1) @[Independence.scala 88:41]
    node _T_4 = mux(ctrl.in.valid, _T_3, UInt<1>("h0")) @[Independence.scala 88:17]
    n_reg <= _T_4 @[Independence.scala 88:11]
    ctrl.out.valid <= UInt<1>("h1") @[Independence.scala 89:20]
    out.data <= reg @[Independence.scala 90:14]

  module DecoupledIODemo_6 :
    input clock : Clock
    input reset : Reset
    output ctrl : { in : { flip valid : UInt<1>, ready : UInt<1>}, flip out : { flip valid : UInt<1>, ready : UInt<1>}, flip clear : UInt<1>}
    output in : { flip data : UInt<8>}
    input out : { flip data : UInt<8>}
  
    wire n_reg : UInt<8> @[Independence.scala 98:21]
    reg reg : UInt, clock with :
      reset => (UInt<1>("h0"), reg) @[Independence.scala 99:22]
    reg <= n_reg @[Independence.scala 99:22]
    ctrl.in.ready <= ctrl.out.ready @[Independence.scala 101:13]
    ctrl.out.valid <= ctrl.in.valid @[Independence.scala 101:13]
    node _T = add(in.data, UInt<1>("h1")) @[Independence.scala 102:41]
    node _T_1 = tail(_T, 1) @[Independence.scala 102:41]
    node _T_2 = mux(ctrl.in.valid, _T_1, UInt<1>("h0")) @[Independence.scala 102:17]
    n_reg <= _T_2 @[Independence.scala 102:11]
    out.data <= reg @[Independence.scala 103:14]

  module IndependenceDemo :
    input clock : Clock
    input reset : UInt<1>
    output in : { flip data : UInt<8>}
    input out : { flip data : UInt<8>}
    output ctrl : { in : { flip valid : UInt<1>, ready : UInt<1>}, flip out : { flip valid : UInt<1>, ready : UInt<1>}, flip clear : UInt<1>}
  
    inst com6 of DecoupledIODemo_6 @[Independence.scala 116:22]
    inst com5 of DecoupledIODemo_5 @[Independence.scala 115:22]
    inst com4 of DecoupledIODemo_4 @[Independence.scala 114:22]
    inst com3 of DecoupledIODemo_3 @[Independence.scala 113:22]
    inst com2 of DecoupledIODemo_2 @[Independence.scala 112:22]
    inst com1 of DecoupledIODemo_1 @[Independence.scala 111:22]
    com1.clock <= clock
    com1.reset <= reset
    com2.clock <= clock
    com2.reset <= reset
    com3.clock <= clock
    com3.reset <= reset
    com4.clock <= clock
    com4.reset <= reset
    com5.clock <= clock
    com5.reset <= reset
    com6.clock <= clock
    com6.reset <= reset
    wire w : { flip data : UInt<8>} @[Independence.scala 118:17]
    w.data <= UInt<3>("h4") @[Independence.scala 119:12]
    com1.ctrl.in.valid <= UInt<1>("h1") @[Independence.scala 127:24]
    com6.ctrl.out.ready <= UInt<1>("h1") @[Independence.scala 128:25]
    com1.in.data <= in.data
    com2.in.data <= com1.out.data
    com1.ctrl.out.ready <= com2.ctrl.in.ready @[IOInterface.scala 149:32]
    com2.ctrl.in.valid <= com1.ctrl.out.valid @[IOInterface.scala 150:28]
    com3.in.data <= com2.out.data
    com2.ctrl.out.ready <= com3.ctrl.in.ready @[IOInterface.scala 149:32]
    com3.ctrl.in.valid <= com2.ctrl.out.valid @[IOInterface.scala 150:28]
    com4.in.data <= com3.out.data
    com3.ctrl.out.ready <= com4.ctrl.in.ready @[IOInterface.scala 149:32]
    com4.ctrl.in.valid <= com3.ctrl.out.valid @[IOInterface.scala 150:28]
    com5.in.data <= com4.out.data
    com4.ctrl.out.ready <= com5.ctrl.in.ready @[IOInterface.scala 149:32]
    com5.ctrl.in.valid <= com4.ctrl.out.valid @[IOInterface.scala 150:28]
    com6.in.data <= com5.out.data
    com5.ctrl.out.ready <= com6.ctrl.in.ready @[IOInterface.scala 149:32]
    com6.ctrl.in.valid <= com5.ctrl.out.valid @[IOInterface.scala 150:28]
    out.data <= com6.out.data
    node _T = or(UInt<1>("h0"), ctrl.clear) @[Driver.scala 98:87]
    com1.ctrl.clear <= _T @[Driver.scala 98:87]
    node _T_1 = or(UInt<1>("h0"), ctrl.clear) @[Driver.scala 98:87]
    com2.ctrl.clear <= _T_1 @[Driver.scala 98:87]
    node _T_2 = or(UInt<1>("h0"), ctrl.clear) @[Driver.scala 98:87]
    com3.ctrl.clear <= _T_2 @[Driver.scala 98:87]
    node _T_3 = or(UInt<1>("h0"), ctrl.clear) @[Driver.scala 98:87]
    com4.ctrl.clear <= _T_3 @[Driver.scala 98:87]
    node _T_4 = or(UInt<1>("h0"), ctrl.clear) @[Driver.scala 98:87]
    com5.ctrl.clear <= _T_4 @[Driver.scala 98:87]
    node _T_5 = or(UInt<1>("h0"), ctrl.clear) @[Driver.scala 98:87]
    com6.ctrl.clear <= _T_5 @[Driver.scala 98:87]
