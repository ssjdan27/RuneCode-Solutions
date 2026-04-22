import std.stdio;
import std.string;
import std.conv;

void main() {
    auto parts = readln().split();
    long a = to!long(parts[0]);
    long b = to!long(parts[1]);
    writeln(a + b);
}