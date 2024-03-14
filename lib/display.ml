(* display.ml *)

let render_char ch = print_char ch
(* match ch with
   | '\n' -> print_char ch
   | _ -> print_char '_' *)

let render_lesson portion input_str =
  let rec loop i =
    if i >= String.length portion
    then print_newline ()
    else (
      let lesson_char = portion.[i] in
      if i < String.length input_str
      then (
        let input_char = input_str.[i] in
        if input_char = lesson_char
        then (
          print_string "\x1b[32m";
          print_char input_char;
          print_string "\x1b[0m")
        else (
          print_string "\x1b[31m";
          print_char input_char;
          print_string "\x1b[0m"))
      else render_char lesson_char;
      loop (i + 1))
  in
  print_string "\r";
  loop 0
;;

let render_stats (session : Types.session) wpm =
  Printf.printf "\nSession Statistics:\n";
  Printf.printf "Correct Keystrokes: %d\n" session.correct_keystrokes;
  Printf.printf "Incorrect Keystrokes: %d\n" session.incorrect_keystrokes;
  Printf.printf "Backspaces: %d\n" session.backspaces;
  Printf.printf "Words per Minute (WPM): %.2f\n" wpm
;;
