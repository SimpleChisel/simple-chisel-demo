package simpleChiselDemo

import chisel3._
import chisel3.util._
import chisel3.simplechisel._
import chisel3.simplechisel.util._

class IndependenceDemoIO extends Bundle {
    val data = Input(UInt(8.W))
}
class DecoupledIODemo_1 extends SimpleChiselModule{
    val ctrl = IO(new DecoupledIOCtrl)
    val in = IO(new IndependenceDemoIO)
    val out = IO(Flipped(new IndependenceDemoIO))

    val n_reg = Wire(UInt(8.W))
    val reg = RegNext(n_reg)

    ctrl.in.ready := true.B
    n_reg := Mux(ctrl.in.valid, in.data, 0.U)
    ctrl.out.valid := true.B
    out.data := reg
}

class DecoupledIODemo_2 extends SimpleChiselModule{
    val ctrl = IO(new DecoupledIOCtrl)
    val in = IO(new IndependenceDemoIO)
    val out = IO(Flipped(new IndependenceDemoIO))

    val n_reg = Wire(UInt(8.W))
    val reg = RegNext(n_reg)

    ctrl.in.ready := ctrl.in.valid
    n_reg := Mux(ctrl.in.valid, in.data, 0.U)
    ctrl.out.valid := true.B
    out.data := reg

}

class DecoupledIODemo_3 extends SimpleChiselModule{
    val ctrl = IO(new DecoupledIOCtrl)
    val in = IO(new IndependenceDemoIO)
    val out = IO(Flipped(new IndependenceDemoIO))

    val n_reg = Wire(UInt(8.W))
    val reg = RegNext(n_reg)

    ctrl.in.ready := true.B
    n_reg := Mux(ctrl.in.valid, in.data, 0.U)
    ctrl.out.valid := ctrl.out.ready
    out.data := reg
}

class DecoupledIODemo_4 extends SimpleChiselModule{
    val ctrl = IO(new DecoupledIOCtrl)
    val in = IO(new IndependenceDemoIO)
    val out = IO(Flipped(new IndependenceDemoIO))

    val n_reg = Wire(UInt(8.W))
    val reg = RegNext(n_reg)

    ctrl.in.ready := ctrl.out.ready
    n_reg := Mux(ctrl.in.valid, (in.data+1.U), 0.U)
    ctrl.out.valid := true.B
    out.data := reg
}


class IndependenceDemo extends Module{
    val in = IO(new IndependenceDemoIO)
    val out = IO(Flipped(new IndependenceDemoIO))

    val com1 = Module(new DecoupledIODemo_1)
    val com2 = Module(new DecoupledIODemo_2)
    val com3 = Module(new DecoupledIODemo_3)
    val com4 = Module(new DecoupledIODemo_4)

    val w = Wire(new IndependenceDemoIO)
    w.data := 4.U
    com1.ctrl.clear := false.B
    com2.ctrl.clear := false.B
    com3.ctrl.clear := false.B
    com4.ctrl.clear := false.B
    com1.ctrl.in.valid := true.B
    com4.ctrl.out.ready := true.B
    in >>> com1 >>> com2 >>> com3 >>> com4 >>> out
}