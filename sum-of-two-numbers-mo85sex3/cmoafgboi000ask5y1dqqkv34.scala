object Main {
  def main(args: Array[String]): Unit = {
    val parts = io.Source.stdin.getLines().mkString(" ").trim.split("\\s+")
    val a = parts(0).toLong
    val b = parts(1).toLong
    println(a + b)
  }
}