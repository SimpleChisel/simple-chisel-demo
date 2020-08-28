package simpleChiselDemo

import chisel3._
import chisel3.util._
import chisel3.simplechisel._
import chisel3.simplechisel.util._

class IndependenceDemoIO extends Bundle {
    val data = Input(UInt(8.W))
}
class DecoupledIODemo_1 extends SimpleChiselModule{
    val ctrl = IO(new DecoupledIOCtrl(4,5))
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
    val ctrl = IO(new DecoupledIOCtrl(4,5))
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
    val ctrl = IO(new DecoupledIOCtrl(4,5))
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
    val ctrl = IO(new DecoupledIOCtrl(4,5))
    val in = IO(new IndependenceDemoIO)
    val out = IO(Flipped(new IndependenceDemoIO))

    val n_reg = Wire(UInt(8.W))
    val reg = RegNext(n_reg)

    val d = in.data
    val next = Mux(ctrl.in.valid, (d + 1.U), 0.U)

    ctrl.in.ready := ctrl.out.ready
    n_reg := next
    ctrl.out.valid := true.B
    out.data := reg
}

class DecoupledIODemo_5 extends SimpleChiselModule{
    val ctrl = IO(new DecoupledIOCtrl(4,5))
    val in = IO(new IndependenceDemoIO)
    val out = IO(Flipped(new IndependenceDemoIO))

    val n_reg = Wire(UInt(8.W))
    val reg = RegNext(n_reg)

    
    when(ctrl.in.valid === false.B){
        ctrl.in.ready := false.B
    }
    .elsewhen(ctrl.in.valid === true.B){
        ctrl.in.ready := true.B
    }.otherwise{
        ctrl.in.ready := true.B
    }
    n_reg := Mux(ctrl.in.valid, (in.data+1.U), 0.U)
    ctrl.out.valid := true.B
    out.data := reg
}

class DecoupledIODemo_6 extends SimpleChiselModule{
    val ctrl = IO(new DecoupledIOCtrl(4,5))
    val in = IO(new IndependenceDemoIO)
    val out = IO(Flipped(new IndependenceDemoIO))

    val n_reg = Wire(UInt(8.W))
    val reg = RegNext(n_reg)

    ctrl.in <> ctrl.out
    n_reg := Mux(ctrl.in.valid, (in.data+1.U), 0.U)
    out.data := reg
}

class IndependenceDemo extends SimpleChiselModule{
    val in = IO(new IndependenceDemoIO)
    val out = IO(Flipped(new IndependenceDemoIO))
    val ctrl = IO(new DecoupledIOCtrl(4,5))
    
    val com1 = Module(new DecoupledIODemo_1)
    val com2 = Module(new DecoupledIODemo_2)
    val com3 = Module(new DecoupledIODemo_3)
    val com4 = Module(new DecoupledIODemo_4)
    val com5 = Module(new DecoupledIODemo_5)
    val com6 = Module(new DecoupledIODemo_6)

    val w = Wire(new IndependenceDemoIO)
    w.data := 4.U
    
    com1.ctrl.in.valid := true.B
    com6.ctrl.out.ready := true.B
    in >>> com1 >>> com2 >>> com3 >>> com4 >>> com5 >>> com6 >>>out
}