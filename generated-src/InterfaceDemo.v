module TightlyCoupledIODemo(
  input        clock,
  input  [7:0] in_data,
  output [7:0] out_data
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] reg_; // @[Interface.scala 15:18]
  assign out_data = reg_ + 8'h1; // @[Interface.scala 28:14]
  always @(posedge clock) begin
    reg_ <= in_data;
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  reg_ = _RAND_0[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module InterfaceDemo(
  input        clock,
  input        reset,
  input  [7:0] in_data,
  output [7:0] out_data
);
  wire  tightlyCoupled_clock; // @[Interface.scala 36:32]
  wire [7:0] tightlyCoupled_in_data; // @[Interface.scala 36:32]
  wire [7:0] tightlyCoupled_out_data; // @[Interface.scala 36:32]
  TightlyCoupledIODemo tightlyCoupled ( // @[Interface.scala 36:32]
    .clock(tightlyCoupled_clock),
    .in_data(tightlyCoupled_in_data),
    .out_data(tightlyCoupled_out_data)
  );
  assign out_data = tightlyCoupled_out_data;
  assign tightlyCoupled_clock = clock;
  assign tightlyCoupled_in_data = in_data;
endmodule
