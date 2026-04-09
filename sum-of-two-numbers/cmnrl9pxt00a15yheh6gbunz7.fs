let parts =
    System.Console.In.ReadToEnd().Split(
        [| ' '; '\n'; '\r'; '\t' |],
        System.StringSplitOptions.RemoveEmptyEntries
    )

let a = System.Int64.Parse(parts.[0])
let b = System.Int64.Parse(parts.[1])
System.Console.WriteLine(a + b)