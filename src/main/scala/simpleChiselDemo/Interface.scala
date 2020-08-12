package simpleChiselDemo

import chisel3._
import chisel3.util._
import chisel3.simplechisel._
import chisel3.simplechisel.util._
class InterfaceDemoIO extends Bundle {
    val data = Input(UInt(8.W))
}
class TightlyCoupledIODemo extends SimpleChiselModule{
    val ctrl = IO(new TightlyCoupledIOCtrl(1))
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

class InterfaceDemo extends SimpleChiselModule{
    val in = IO(new InterfaceDemoIO)
    val out = IO(Flipped(new InterfaceDemoIO))
    val ctrl = IO(new TightlyCoupledIOCtrl(0))
    val tightlyCoupled = Module(new TightlyCoupledIODemo)
    tightlyCoupled.ctrl.stall := false.B
    tightlyCoupled.ctrl.valid_input := true.B
    in >>> tightlyCoupled >>> out
}