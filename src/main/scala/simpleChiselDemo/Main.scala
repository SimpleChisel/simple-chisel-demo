// See LICENSE for license details.

package simpleChiselDemo

import java.io.{File, FileWriter}
import chisel3.stage._
object Main extends App {
  val dir = new File(args(0)) ; dir.mkdirs

  // /***For FSM generation***/
  // val chirrtl_FSM = firrtl.Parser.parse(chisel3.Driver.emit(() => new FSM))
  // val writer_FSM = new FileWriter(new File(dir, s"${chirrtl_FSM.main}.fir"))
  // writer_FSM write chirrtl_FSM.serialize
  // writer_FSM.close

  // val verilog_FSM = new FileWriter(new File(dir, s"${chirrtl_FSM.main}.v"))
  // verilog_FSM write (new firrtl.VerilogCompiler).compileAndEmit(firrtl.CircuitState(chirrtl_FSM, firrtl.ChirrtlForm)).getEmittedCircuit.value
  // verilog_FSM.close

  // /***For BasicConnection***/
  // val chirrtl_BasicConnection = firrtl.Parser.parse(chisel3.Driver.emit(() => new BasicConnection))
  // val writer_BasicConnection = new FileWriter(new File(dir, s"${chirrtl_BasicConnection.main}.fir"))
  // writer_BasicConnection write chirrtl_BasicConnection.serialize
  // writer_BasicConnection.close

  // val verilog_BasicConnection = new FileWriter(new File(dir, s"${chirrtl_BasicConnection.main}.v"))
  // verilog_BasicConnection write (new firrtl.VerilogCompiler).compileAndEmit(firrtl.CircuitState(chirrtl_BasicConnection, firrtl.ChirrtlForm)).getEmittedCircuit.value
  // verilog_BasicConnection.close
  // /***For BulkConnection***/

  val chirrtl_BulkConnection = firrtl.Parser.parse(chisel3.Driver.emit(() => new BulkConnection))
  val writer_BulkConnection = new FileWriter(new File(dir, s"${chirrtl_BulkConnection.main}.fir"))
  writer_BulkConnection write chirrtl_BulkConnection.serialize
  writer_BulkConnection.close

  // val verilog_BulkConnection = new FileWriter(new File(dir, s"${chirrtl_BulkConnection.main}.v"))
  // verilog_BulkConnection write (new firrtl.VerilogCompiler).compileAndEmit(firrtl.CircuitState(chirrtl_BulkConnection, firrtl.ChirrtlForm)).getEmittedCircuit.value
  // verilog_BulkConnection.close

  // /***For Interface Demo***/


  // val verilog_InterfaceDemo = new FileWriter(new File(dir, s"${chirrtl_InterfaceDemo.main}.v"))
  // verilog_InterfaceDemo write (new firrtl.VerilogCompiler).compileAndEmit(firrtl.CircuitState(chirrtl_InterfaceDemo, firrtl.ChirrtlForm)).getEmittedCircuit.value
  // verilog_InterfaceDemo.close

  /***For Indepenence Demo***/
  

  // val verilog_IndependenceDemo = new FileWriter(new File(dir, s"${chirrtl_IndependenceDemo.main}.v"))
  // verilog_IndependenceDemo write (new firrtl.VerilogCompiler).compileAndEmit(firrtl.CircuitState(chirrtl_IndependenceDemo, firrtl.ChirrtlForm)).getEmittedCircuit.value
  // verilog_IndependenceDemo.close

  // val chirrtl_UniqueIdTestClass = firrtl.Parser.parse(chisel3.Driver.emit(() => new UniqueIdTestClass))
  // val writer_UniqueIdTestClass = new FileWriter(new File(dir, s"${chirrtl_UniqueIdTestClass.main}.fir"))
  // writer_UniqueIdTestClass write chirrtl_UniqueIdTestClass.serialize
  // writer_UniqueIdTestClass.close

  // val verilog_UniqueIdTestClass = new FileWriter(new File(dir, s"${chirrtl_UniqueIdTestClass.main}.v"))
  // verilog_UniqueIdTestClass write (new firrtl.VerilogCompiler).compileAndEmit(firrtl.CircuitState(chirrtl_UniqueIdTestClass, firrtl.ChirrtlForm)).getEmittedCircuit.value
  // verilog_UniqueIdTestClass.close
}