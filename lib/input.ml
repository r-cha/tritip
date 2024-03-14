(* input.ml *)

let read_char () =
  let terminfo = Unix.tcgetattr Unix.stdin in
  let () =
    Unix.tcsetattr
      Unix.stdin
      Unix.TCSADRAIN
      { terminfo with Unix.c_icanon = false; Unix.c_echo = false }
  in
  let result = input_char stdin in
  let () = Unix.tcsetattr Unix.stdin Unix.TCSADRAIN terminfo in
  result
;;

let read_input portion =
  let rec loop input_str =
    match read_char () with
    | exception End_of_file -> input_str
    | '\r' -> input_str
    | ch ->
      let input_str = input_str ^ String.make 1 ch in
      if String.length input_str >= String.length portion
      then input_str
      else loop input_str
  in
  loop ""
;;
