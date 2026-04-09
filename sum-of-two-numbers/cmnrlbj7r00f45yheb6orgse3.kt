fun main() {
    val parts = generateSequence(::readLine).joinToString(" ").trim().split(Regex("\\s+"))
    val a = parts[0].toLong()
    val b = parts[1].toLong()
    println(a + b)
}