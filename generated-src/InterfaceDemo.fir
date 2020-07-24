circuit InterfaceDemo :
  module TightlyCoupledIODemo :
    input clock : Clock
    input reset : Reset
    output ctrl : { flip stall : UInt<1>, flip clear : UInt<1>, stuck : UInt<1>}
    output in : { flip data : UInt<8>}
    input out : { flip data : UInt<8>}
  
    wire n_reg : UInt<8> @[Interface.scala 14:21]
    reg reg : UInt<8>, clock with :
      reset => (UInt<1>("h0"), reg) @[Interface.scala 15:18]
    when ctrl.stall : @[Interface.scala 17:21]
      n_reg <= reg @[Interface.scala 18:15]
      skip
    else :
      when ctrl.clear : @[Interface.scala 20:26]
        n_reg <= UInt<1>("h0") @[Interface.scala 21:15]
        skip
      else :
        n_reg <= in.data @[Interface.scala 24:15]
        skip
    reg <= n_reg @[Interface.scala 26:9]
    node _T = add(reg, UInt<1>("h1")) @[Interface.scala 28:21]
    node _T_1 = tail(_T, 1) @[Interface.scala 28:21]
    out.data <= _T_1 @[Interface.scala 28:14]
    ctrl.stuck <= UInt<1>("h0") @[Interface.scala 29:16]

  module InterfaceDemo :
    input clock : Clock
    input reset : UInt<1>
    output in : { flip data : UInt<8>}
    input out : { flip data : UInt<8>}
  
    inst tightlyCoupled of TightlyCoupledIODemo @[Interface.scala 36:32]
    tightlyCoupled.clock <= clock
    tightlyCoupled.reset <= reset
    tightlyCoupled.ctrl.stall <= UInt<1>("h0") @[Interface.scala 37:31]
    tightlyCoupled.ctrl.clear <= UInt<1>("h0") @[Interface.scala 38:31]
    tightlyCoupled.in.data <= in.data
    out.data <= tightlyCoupled.out.data
