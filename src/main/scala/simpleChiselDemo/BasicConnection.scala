// See README.md for license details.

package simpleChiselDemo

import chisel3._
import chisel3.simplechisel._
import chisel3.simplechisel.util._
class BasicConnectionIO extends Bundle{
  val value = UInt(16.W)
  val enable = Bool()
}

class BasicConnection extends Module{
  val in = IO(Input(new BasicConnectionIO))
  val out = IO(Output(new BasicConnectionIO))
  in.value >>> out.value
  in.enable >>> out.enable
}