circuit InterfaceDemo :
  module TightlyCoupledIODemo :
    input clock : Clock
    input reset : Reset
    output ctrl : { flip stall : UInt<1>, flip clear : UInt<1>, stuck : UInt<1>, flip valid_input : UInt<1>, valid_output : UInt<1>}
    output in : { flip data : UInt<8>}
    input out : { flip data : UInt<8>}
  
    wire n_reg : UInt<8> @[Interface.scala 15:21]
    reg reg : UInt<8>, clock with :
      reset => (UInt<1>("h0"), reg) @[Interface.scala 16:18]
    when ctrl.stall : @[Interface.scala 18:21]
      n_reg <= reg @[Interface.scala 19:15]
      skip
    else :
      when ctrl.clear : @[Interface.scala 21:26]
        n_reg <= UInt<1>("h0") @[Interface.scala 22:15]
        skip
      else :
        n_reg <= in.data @[Interface.scala 25:15]
        skip
    reg <= n_reg @[Interface.scala 27:9]
    node _T = add(reg, UInt<1>("h1")) @[Interface.scala 29:21]
    node _T_1 = tail(_T, 1) @[Interface.scala 29:21]
    out.data <= _T_1 @[Interface.scala 29:14]
    ctrl.stuck <= UInt<1>("h0") @[Interface.scala 30:16]
    reg _T_2 : UInt<1>[1], clock with :
      reset => (UInt<1>("h0"), _T_2) @[SimpleChiselAbstraction.scala 230:40]
    node _T_3 = or(ctrl.stall, ctrl.stuck) @[SimpleChiselAbstraction.scala 231:29]
    when _T_3 : @[SimpleChiselAbstraction.scala 231:41]
      _T_2[0] <= _T_2[0] @[SimpleChiselAbstraction.scala 232:36]
      ctrl.valid_output <= UInt<1>("h0") @[SimpleChiselAbstraction.scala 233:32]
      skip
    else :
      _T_2[0] <= ctrl.valid_input @[SimpleChiselAbstraction.scala 235:36]
      ctrl.valid_output <= _T_2[0] @[SimpleChiselAbstraction.scala 236:32]
      skip

  module InterfaceDemo :
    input clock : Clock
    input reset : UInt<1>
    output in : { flip data : UInt<8>}
    input out : { flip data : UInt<8>}
    output ctrl : { flip stall : UInt<1>, flip clear : UInt<1>, stuck : UInt<1>, flip valid_input : UInt<1>, valid_output : UInt<1>}
  
    inst tightlyCoupled of TightlyCoupledIODemo @[Interface.scala 37:32]
    tightlyCoupled.clock <= clock
    tightlyCoupled.reset <= reset
    tightlyCoupled.ctrl.stall <= UInt<1>("h0") @[Interface.scala 38:31]
    tightlyCoupled.ctrl.valid_input <= UInt<1>("h1") @[Interface.scala 39:37]
    tightlyCoupled.in.data <= in.data
    out.data <= tightlyCoupled.out.data
    tightlyCoupled.ctrl.clear <= ctrl.clear @[Driver.scala 98:87]
