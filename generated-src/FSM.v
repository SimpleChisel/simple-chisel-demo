module FSMState(
  input         clock,
  input  [15:0] io_in_value1,
  input  [15:0] io_in_value2,
  input  [1:0]  io_in_counter,
  output [15:0] io_out_value1,
  output [15:0] io_out_value2,
  output [1:0]  io_out_counter
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [15:0] value1; // @[SimpleChiselAbstractions.scala 18:23]
  reg [15:0] value2; // @[SimpleChiselAbstractions.scala 19:23]
  reg [1:0] counter; // @[SimpleChiselAbstractions.scala 20:24]
  assign io_out_value1 = value1; // @[SimpleChiselAbstractions.scala 22:17]
  assign io_out_value2 = value2; // @[SimpleChiselAbstractions.scala 23:17]
  assign io_out_counter = counter; // @[SimpleChiselAbstractions.scala 24:18]
  always @(posedge clock) begin
    value1 <= io_in_value1;
    value2 <= io_in_value2;
    counter <= io_in_counter;
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
  value1 = _RAND_0[15:0];
  _RAND_1 = {1{`RANDOM}};
  value2 = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  counter = _RAND_2[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module FSMLogic(
  input  [15:0] io_in_value1,
  input  [15:0] io_in_value2,
  input  [1:0]  io_in_counter,
  output [15:0] io_out_value1,
  output [15:0] io_out_value2,
  output [1:0]  io_out_counter
);
  wire  _T_4 = io_in_counter == 2'h3; // @[SimpleChiselAbstractions.scala 40:39]
  wire [1:0] _T_6 = io_in_counter + 2'h1; // @[SimpleChiselAbstractions.scala 40:72]
  assign io_out_value1 = io_in_value1 + 16'h1; // @[SimpleChiselAbstractions.scala 38:17]
  assign io_out_value2 = io_in_value2 + 16'h1; // @[SimpleChiselAbstractions.scala 39:17]
  assign io_out_counter = _T_4 ? 2'h0 : _T_6; // @[SimpleChiselAbstractions.scala 40:18]
endmodule
module FSM(
  input         clock,
  input         reset,
  input  [15:0] io_in_value1,
  input  [15:0] io_in_value2,
  input         io_in_valid,
  output [15:0] io_out_value1,
  output [15:0] io_out_value2,
  output        io_out_valid
);
  wire  state_clock; // @[SimpleChiselAbstractions.scala 56:20]
  wire [15:0] state_io_in_value1; // @[SimpleChiselAbstractions.scala 56:20]
  wire [15:0] state_io_in_value2; // @[SimpleChiselAbstractions.scala 56:20]
  wire [1:0] state_io_in_counter; // @[SimpleChiselAbstractions.scala 56:20]
  wire [15:0] state_io_out_value1; // @[SimpleChiselAbstractions.scala 56:20]
  wire [15:0] state_io_out_value2; // @[SimpleChiselAbstractions.scala 56:20]
  wire [1:0] state_io_out_counter; // @[SimpleChiselAbstractions.scala 56:20]
  wire [15:0] logic__io_in_value1; // @[SimpleChiselAbstractions.scala 57:20]
  wire [15:0] logic__io_in_value2; // @[SimpleChiselAbstractions.scala 57:20]
  wire [1:0] logic__io_in_counter; // @[SimpleChiselAbstractions.scala 57:20]
  wire [15:0] logic__io_out_value1; // @[SimpleChiselAbstractions.scala 57:20]
  wire [15:0] logic__io_out_value2; // @[SimpleChiselAbstractions.scala 57:20]
  wire [1:0] logic__io_out_counter; // @[SimpleChiselAbstractions.scala 57:20]
  FSMState state ( // @[SimpleChiselAbstractions.scala 56:20]
    .clock(state_clock),
    .io_in_value1(state_io_in_value1),
    .io_in_value2(state_io_in_value2),
    .io_in_counter(state_io_in_counter),
    .io_out_value1(state_io_out_value1),
    .io_out_value2(state_io_out_value2),
    .io_out_counter(state_io_out_counter)
  );
  FSMLogic logic_ ( // @[SimpleChiselAbstractions.scala 57:20]
    .io_in_value1(logic__io_in_value1),
    .io_in_value2(logic__io_in_value2),
    .io_in_counter(logic__io_in_counter),
    .io_out_value1(logic__io_out_value1),
    .io_out_value2(logic__io_out_value2),
    .io_out_counter(logic__io_out_counter)
  );
  assign io_out_value1 = state_io_out_value1; // @[SimpleChiselAbstractions.scala 68:17]
  assign io_out_value2 = state_io_out_value2; // @[SimpleChiselAbstractions.scala 69:17]
  assign io_out_valid = state_io_out_counter == 2'h3; // @[SimpleChiselAbstractions.scala 67:16]
  assign state_clock = clock;
  assign state_io_in_value1 = io_in_valid ? io_in_value1 : logic__io_out_value1; // @[SimpleChiselAbstractions.scala 58:22]
  assign state_io_in_value2 = io_in_valid ? io_in_value2 : logic__io_out_value2; // @[SimpleChiselAbstractions.scala 59:22]
  assign state_io_in_counter = io_in_valid ? 2'h0 : logic__io_out_counter; // @[SimpleChiselAbstractions.scala 60:23]
  assign logic__io_in_value1 = state_io_out_value1; // @[SimpleChiselAbstractions.scala 62:22]
  assign logic__io_in_value2 = state_io_out_value2; // @[SimpleChiselAbstractions.scala 63:22]
  assign logic__io_in_counter = state_io_out_counter; // @[SimpleChiselAbstractions.scala 64:23]
endmodule
