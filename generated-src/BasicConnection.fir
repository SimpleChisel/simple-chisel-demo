circuit BasicConnection :
  module BasicConnection :
    input clock : Clock
    input reset : UInt<1>
    input in : { value : UInt<16>, enable : UInt<1>}
    output out : { value : UInt<16>, enable : UInt<1>}
    output ctrl : { }
  
    out.value <= in.value @[BasicConnection.scala 17:12]
    out.enable <= in.enable @[BasicConnection.scala 18:13]
