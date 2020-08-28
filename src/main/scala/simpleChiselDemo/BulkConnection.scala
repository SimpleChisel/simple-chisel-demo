// See README.md for license details.

package simpleChiselDemo

import chisel3._
import chisel3.util._
import chisel3.simplechisel._
import chisel3.simplechisel.util._
class BulkConnectionIO extends Bundle{
  val value = Vec(3, UInt(16.W))
  val enable = Bool()
}

class BulkConnectionComponent extends SimpleChiselLogic{
  val ctrl = IO(new NoIOCtrl)
  val in = IO(Input(new BulkConnectionIO))
  val out = IO(Output(new BulkConnectionIO))

  in >>> out

}

class BulkConnection extends SimpleChiselModule{
  val ctrl = IO(new TightlyCoupledIOCtrl(0))
  val in = IO(Input(new BulkConnectionIO))
  val out = IO(Output(new BulkConnectionIO))

  val between_2_n_3 = Wire(new BulkConnectionIO)

  val componet1 = Logic(new BulkConnectionComponent)
  val componet2 = Logic(new BulkConnectionComponent)
  val componet3 = Logic(new BulkConnectionComponent)

  in >>> componet1 >>> componet2 >>> between_2_n_3 >>> componet3 >>> out
  ctrl.stuck := false.B
}