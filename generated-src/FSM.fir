circuit FSM :
  module FSMState :
    input clock : Clock
    input reset : Reset
    output io : { flip in_value1 : UInt<16>, flip in_value2 : UInt<16>, flip in_counter : UInt<2>, out_value1 : UInt<16>, out_value2 : UInt<16>, out_counter : UInt<2>}
    output in : { }
    output out : { }
  
    reg value1 : UInt, clock with :
      reset => (UInt<1>("h0"), value1) @[SimpleChiselAbstractions.scala 18:23]
    value1 <= io.in_value1 @[SimpleChiselAbstractions.scala 18:23]
    reg value2 : UInt, clock with :
      reset => (UInt<1>("h0"), value2) @[SimpleChiselAbstractions.scala 19:23]
    value2 <= io.in_value2 @[SimpleChiselAbstractions.scala 19:23]
    reg counter : UInt, clock with :
      reset => (UInt<1>("h0"), counter) @[SimpleChiselAbstractions.scala 20:24]
    counter <= io.in_counter @[SimpleChiselAbstractions.scala 20:24]
    io.out_value1 <= value1 @[SimpleChiselAbstractions.scala 22:17]
    io.out_value2 <= value2 @[SimpleChiselAbstractions.scala 23:17]
    io.out_counter <= counter @[SimpleChiselAbstractions.scala 24:18]

  module FSMLogic :
    input clock : Clock
    input reset : Reset
    output io : { flip in_value1 : UInt<16>, flip in_value2 : UInt<16>, flip in_counter : UInt<2>, out_value1 : UInt<16>, out_value2 : UInt<16>, out_counter : UInt<2>}
    output in : { }
    output out : { }
  
    node _T = add(io.in_value1, UInt<1>("h1")) @[SimpleChiselAbstractions.scala 38:33]
    node _T_1 = tail(_T, 1) @[SimpleChiselAbstractions.scala 38:33]
    io.out_value1 <= _T_1 @[SimpleChiselAbstractions.scala 38:17]
    node _T_2 = add(io.in_value2, UInt<1>("h1")) @[SimpleChiselAbstractions.scala 39:33]
    node _T_3 = tail(_T_2, 1) @[SimpleChiselAbstractions.scala 39:33]
    io.out_value2 <= _T_3 @[SimpleChiselAbstractions.scala 39:17]
    node _T_4 = eq(io.in_counter, UInt<2>("h3")) @[SimpleChiselAbstractions.scala 40:39]
    node _T_5 = add(io.in_counter, UInt<1>("h1")) @[SimpleChiselAbstractions.scala 40:72]
    node _T_6 = tail(_T_5, 1) @[SimpleChiselAbstractions.scala 40:72]
    node _T_7 = mux(_T_4, UInt<1>("h0"), _T_6) @[SimpleChiselAbstractions.scala 40:24]
    io.out_counter <= _T_7 @[SimpleChiselAbstractions.scala 40:18]

  module FSM :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in_value1 : UInt<16>, flip in_value2 : UInt<16>, flip in_valid : UInt<1>, out_value1 : UInt<16>, out_value2 : UInt<16>, out_valid : UInt<1>}
    output in : { }
    output out : { }
  
    inst state of FSMState @[SimpleChiselAbstractions.scala 56:20]
    state.clock <= clock
    state.reset <= reset
    inst logic of FSMLogic @[SimpleChiselAbstractions.scala 57:20]
    logic.clock <= clock
    logic.reset <= reset
    node _T = mux(io.in_valid, io.in_value1, logic.io.out_value1) @[SimpleChiselAbstractions.scala 58:28]
    state.io.in_value1 <= _T @[SimpleChiselAbstractions.scala 58:22]
    node _T_1 = mux(io.in_valid, io.in_value2, logic.io.out_value2) @[SimpleChiselAbstractions.scala 59:28]
    state.io.in_value2 <= _T_1 @[SimpleChiselAbstractions.scala 59:22]
    node _T_2 = mux(io.in_valid, UInt<1>("h0"), logic.io.out_counter) @[SimpleChiselAbstractions.scala 60:29]
    state.io.in_counter <= _T_2 @[SimpleChiselAbstractions.scala 60:23]
    logic.io.in_value1 <= state.io.out_value1 @[SimpleChiselAbstractions.scala 62:22]
    logic.io.in_value2 <= state.io.out_value2 @[SimpleChiselAbstractions.scala 63:22]
    logic.io.in_counter <= state.io.out_counter @[SimpleChiselAbstractions.scala 64:23]
    node _T_3 = eq(state.io.out_counter, UInt<2>("h3")) @[SimpleChiselAbstractions.scala 67:41]
    io.out_valid <= _T_3 @[SimpleChiselAbstractions.scala 67:16]
    io.out_value1 <= state.io.out_value1 @[SimpleChiselAbstractions.scala 68:17]
    io.out_value2 <= state.io.out_value2 @[SimpleChiselAbstractions.scala 69:17]
