// See README.md for license details.

package simpleChiselDemo

import chisel3._

class FSMState extends State {
  val io = IO(new Bundle {
    val in_value1        = Input(UInt(16.W))
    val in_value2        = Input(UInt(16.W))
    val in_counter    = Input(UInt(2.W))
    val out_value1        = Output(UInt(16.W))
    val out_value2        = Output(UInt(16.W))
    val out_counter    = Output(UInt(2.W))
  })
  val in = IO(new Bundle() {})
  val out = IO(new Bundle() {})
  val value1 = RegNext(io.in_value1)
  val value2 = RegNext(io.in_value2)
  val counter = RegNext(io.in_counter)

  io.out_value1 := value1
  io.out_value2 := value2
  io.out_counter := counter
}

class FSMLogic extends Logic {
  val io = IO(new Bundle {
    val in_value1        = Input(UInt(16.W))
    val in_value2        = Input(UInt(16.W))
    val in_counter    = Input(UInt(2.W))
    val out_value1        = Output(UInt(16.W))
    val out_value2        = Output(UInt(16.W))
    val out_counter    = Output(UInt(2.W))
  })
  val in = IO(new Bundle() {})
  val out = IO(new Bundle() {})
  io.out_value1 := io.in_value1 + 1.U
  io.out_value2 := io.in_value2 + 1.U
  io.out_counter := Mux(io.in_counter === 3.U(2.W), 0.U, io.in_counter + 1.U)
}

class FSMIO extends Bundle{
    val in_value1        = Input(UInt(16.W))
    val in_value2        = Input(UInt(16.W))
    val in_valid         = Input(Bool())
    val out_value1        = Output(UInt(16.W))
    val out_value2        = Output(UInt(16.W))
    val out_valid         = Output(Bool())
}

class FSM extends Module {
  val io = IO(new FSMIO)
  val in = IO(new Bundle() {})
  val out = IO(new Bundle() {})
  val state = State(new FSMState)
  val logic = Logic(new FSMLogic)
  state.io.in_value1 := Mux(io.in_valid, io.in_value1, logic.io.out_value1)
  state.io.in_value2 := Mux(io.in_valid, io.in_value2, logic.io.out_value2)
  state.io.in_counter := Mux(io.in_valid, 0.U, logic.io.out_counter)

  logic.io.in_value1 := state.io.out_value1
  logic.io.in_value2 := state.io.out_value2
  logic.io.in_counter := state.io.out_counter

  //Assign output
  io.out_valid := (state.io.out_counter === 3.U(2.W))
  io.out_value1 := state.io.out_value1
  io.out_value2 := state.io.out_value2

}
