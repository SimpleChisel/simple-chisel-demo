// See README.md for license details.

package gcd

import chisel3._

class ComponentIO extends Bundle{
  val value = UInt(16.W)
  val enable = Bool()
}

class Component extends Logic{
  val in = IO(Input(new ComponentIO))
  val out = IO(Output(new ComponentIO))
  in >>> out
}

class Datapath extends Module{
  val in = IO(Input(new ComponentIO))
  val out = IO(Output(new ComponentIO))

  val between_2_n_3 = Wire(new ComponentIO)

  val componet1 = Logic(new Component)
  val componet2 = Logic(new Component)
  val componet3 = Logic(new Component)

  in >>> componet1 >>> componet2 >>> between_2_n_3 >>> componet3 >>> out
}