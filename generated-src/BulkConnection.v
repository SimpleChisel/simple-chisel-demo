module BulkConnectionComponent(
  input  [15:0] in_value,
  input         in_enable,
  output [15:0] out_value,
  output        out_enable
);
  assign out_value = in_value;
  assign out_enable = in_enable;
endmodule
module BulkConnection(
  input         clock,
  input         reset,
  input         ctrl_stall,
  input         ctrl_clear,
  output        ctrl_stuck,
  input  [15:0] in_value,
  input         in_enable,
  output [15:0] out_value,
  output        out_enable
);
  wire [15:0] componet1_in_value; // @[BulkConnection.scala 29:24]
  wire  componet1_in_enable; // @[BulkConnection.scala 29:24]
  wire [15:0] componet1_out_value; // @[BulkConnection.scala 29:24]
  wire  componet1_out_enable; // @[BulkConnection.scala 29:24]
  wire [15:0] componet2_in_value; // @[BulkConnection.scala 30:24]
  wire  componet2_in_enable; // @[BulkConnection.scala 30:24]
  wire [15:0] componet2_out_value; // @[BulkConnection.scala 30:24]
  wire  componet2_out_enable; // @[BulkConnection.scala 30:24]
  wire [15:0] componet3_in_value; // @[BulkConnection.scala 31:24]
  wire  componet3_in_enable; // @[BulkConnection.scala 31:24]
  wire [15:0] componet3_out_value; // @[BulkConnection.scala 31:24]
  wire  componet3_out_enable; // @[BulkConnection.scala 31:24]
  BulkConnectionComponent componet1 ( // @[BulkConnection.scala 29:24]
    .in_value(componet1_in_value),
    .in_enable(componet1_in_enable),
    .out_value(componet1_out_value),
    .out_enable(componet1_out_enable)
  );
  BulkConnectionComponent componet2 ( // @[BulkConnection.scala 30:24]
    .in_value(componet2_in_value),
    .in_enable(componet2_in_enable),
    .out_value(componet2_out_value),
    .out_enable(componet2_out_enable)
  );
  BulkConnectionComponent componet3 ( // @[BulkConnection.scala 31:24]
    .in_value(componet3_in_value),
    .in_enable(componet3_in_enable),
    .out_value(componet3_out_value),
    .out_enable(componet3_out_enable)
  );
  assign ctrl_stuck = 1'h0; // @[BulkConnection.scala 34:14]
  assign out_value = componet3_out_value;
  assign out_enable = componet3_out_enable;
  assign componet1_in_value = in_value;
  assign componet1_in_enable = in_enable;
  assign componet2_in_value = componet1_out_value;
  assign componet2_in_enable = componet1_out_enable;
  assign componet3_in_value = componet2_out_value;
  assign componet3_in_enable = componet2_out_enable;
endmodule
