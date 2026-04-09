let () =
  let parts = String.split_on_char ' ' (String.trim (input_line stdin)) in
  let a = int_of_string (List.nth parts 0) in
  let b = int_of_string (List.nth parts 1) in
  Printf.printf "%d\n" (a + b)