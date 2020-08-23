package simpleChiselDemo

import chisel3._
import chisel3.internal._
import chisel3.internal.firrtl._

class TestBundle extends Bundle{
    val data_in1 = UInt(2.W)
    val data_in2 = UInt(2.W)
}

class UniqueIdTestClass extends Module{
    val io = Input(new TestBundle)
    val data_1 = Wire(new TestBundle)
    val data_2 = Wire(new TestBundle)
    val v = Wire(Vec(3, UInt(3.W)))
    Console.println(s"io:data_in1: ${io.data_in1.ref.uniqueId}, ${io.data_in1.ref.uniqueId}")
    Console.println(s"data_1:data_in1: ${data_1.data_in1.ref.uniqueId}, ${data_1.data_in1.ref.uniqueId}")
    Console.println(s"data_1:ldata_in1: ${data_1.data_in1.lref.uniqueId}, ${data_1.data_in1.lref.uniqueId}")
    Console.println(s"data_1:ldata_in2: ${data_1.data_in2.lref.uniqueId}, ${data_1.data_in2.lref.uniqueId}")
    Console.println(s"data_1:data_in2: ${data_1.data_in2.ref.uniqueId}, ${data_1.data_in2.ref.uniqueId}")
    Console.println(s"data_2:data_in1: ${data_2.data_in1.ref.uniqueId}, ${data_2.data_in1.ref.uniqueId}")
    Console.println(s"data_2:data_in2: ${data_2.data_in2.ref.uniqueId}, ${data_2.data_in2.ref.uniqueId}")
    Console.println(s"v:v1: ${v(0).ref.uniqueId}, ${v(0).ref.uniqueId}")
    Console.println(s"v:v2: ${v(1).ref.uniqueId}, ${v(1).ref.uniqueId}")

}