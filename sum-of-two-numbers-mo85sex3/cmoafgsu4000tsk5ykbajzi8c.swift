import Foundation

let data = FileHandle.standardInput.readDataToEndOfFile()
let input = String(data: data, encoding: .utf8) ?? ""
let parts = input.split(separator: " ")
let a = Int64(parts[0].trimmingCharacters(in: .whitespacesAndNewlines))!
let b = Int64(parts[1].trimmingCharacters(in: .whitespacesAndNewlines))!
print(a + b)