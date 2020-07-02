module BasicConnection(
  input         clock,
  input         reset,
  input  [15:0] in_value,
  input         in_enable,
  output [15:0] out_value,
  output        out_enable
);
  assign out_value = in_value; // @[BasicConnection.scala 15:12]
  assign out_enable = in_enable; // @[BasicConnection.scala 16:13]
endmodule
