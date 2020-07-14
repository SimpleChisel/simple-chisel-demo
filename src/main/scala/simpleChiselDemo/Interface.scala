package simpleChiselDemo

import chisel3._
import chisel3.util._

class InterfaceDemoIO extends Bundle {
    val data = Input(UInt(8.W))
}
class TightlyCoupledIODemo extends Module with TightlyCoupledModuleIO{
    val in = IO(new InterfaceDemoIO)
    val out = IO(Flipped(new InterfaceDemoIO))

    val n_reg = Wire(UInt(8.W))
    val reg = Reg(UInt(8.W))

    when(ctrl.stall){
        n_reg := reg
    }
    .elsewhen(ctrl.clear){
        n_reg := 0.U
    }
    .otherwise{
        n_reg := in.data
    }
    reg := n_reg
    
    out.data := reg + 1.U(1.W)
    ctrl.stuck := false.B
}

class InterfaceDemo extends Module{
    val in = IO(new InterfaceDemoIO)
    val out = IO(Flipped(new InterfaceDemoIO))

    val tightlyCoupled = Module(new TightlyCoupledIODemo)
    tightlyCoupled.ctrl.stall := false.B
    tightlyCoupled.ctrl.clear := false.B

    in >>> tightlyCoupled >>> out
}