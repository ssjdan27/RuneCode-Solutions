Imports System

Module Program
    Sub Main()
        Dim separators As Char() = {" "c, ControlChars.Tab, ControlChars.Cr, ControlChars.Lf}
        Dim parts As String() = Console.In.ReadToEnd().Split(separators, StringSplitOptions.RemoveEmptyEntries)
        Dim a As Long = Long.Parse(parts(0))
        Dim b As Long = Long.Parse(parts(1))
        Console.WriteLine(a + b)
    End Sub
End Module