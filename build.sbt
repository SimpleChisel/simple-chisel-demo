val commonSettings = Seq(
  scalaVersion := "2.12.4",
  crossScalaVersions := Seq("2.11.12", "2.12.4"),
  libraryDependencies ++= Seq(
    "edu.umich.engin.eecs" %% "chisel3" % "0.1-SNAPSHOT",
    "org.scalatest" %% "scalatest" % "3.0.1"
  ),
  resolvers ++= Seq(
    Resolver.sonatypeRepo("snapshots"),
    Resolver.sonatypeRepo("releases")
  )
)

val demoSettings = commonSettings ++ Seq(
  name := "simpleChiselDemo",
  version := "0.1",
  organization := "edu.umich.engin.eecs")

lazy val lib  = project settings commonSettings
lazy val demo = project in file(".") settings demoSettings dependsOn lib