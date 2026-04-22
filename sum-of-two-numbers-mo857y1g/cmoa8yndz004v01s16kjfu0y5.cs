using System;

class Program
{
    static void Main()
    {
        var parts = Console.In.ReadToEnd()
            .Split((char[])null, StringSplitOptions.RemoveEmptyEntries);
        long a = long.Parse(parts[0]);
        long b = long.Parse(parts[1]);
        Console.WriteLine(a + b);
    }
}