circuit BulkConnection :
  module BulkConnectionComponent :
    input clock : Clock
    input reset : Reset
    input in : { value : UInt<16>, enable : UInt<1>}
    output out : { value : UInt<16>, enable : UInt<1>}
  
    out.enable <= in.enable
    out.value <= in.value

  module BulkConnectionComponent_1 :
    input clock : Clock
    input reset : Reset
    input in : { value : UInt<16>, enable : UInt<1>}
    output out : { value : UInt<16>, enable : UInt<1>}
  
    out.enable <= in.enable
    out.value <= in.value

  module BulkConnectionComponent_2 :
    input clock : Clock
    input reset : Reset
    input in : { value : UInt<16>, enable : UInt<1>}
    output out : { value : UInt<16>, enable : UInt<1>}
  
    out.enable <= in.enable
    out.value <= in.value

  module BulkConnection :
    input clock : Clock
    input reset : UInt<1>
    input in : { value : UInt<16>, enable : UInt<1>}
    output out : { value : UInt<16>, enable : UInt<1>}
  
    wire between_2_n_3 : { value : UInt<16>, enable : UInt<1>} @[BulkConnection.scala 22:27]
    inst componet1 of BulkConnectionComponent @[BulkConnection.scala 24:24]
    componet1.clock <= clock
    componet1.reset <= reset
    inst componet2 of BulkConnectionComponent_1 @[BulkConnection.scala 25:24]
    componet2.clock <= clock
    componet2.reset <= reset
    inst componet3 of BulkConnectionComponent_2 @[BulkConnection.scala 26:24]
    componet3.clock <= clock
    componet3.reset <= reset
    componet1.in.enable <= in.enable
    componet1.in.value <= in.value
    componet2.in.enable <= componet1.out.enable
    componet2.in.value <= componet1.out.value
    between_2_n_3.enable <= componet2.out.enable
    between_2_n_3.value <= componet2.out.value
    componet3.in.enable <= between_2_n_3.enable
    componet3.in.value <= between_2_n_3.value
    out.enable <= componet3.out.enable
    out.value <= componet3.out.value
