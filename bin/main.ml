(* main.ml *)

open Tritip

let main () =
  match Sys.argv with
  | [| _; filename |] ->
    (* Load the lesson file *)
    let lesson = Lesson.load_file filename in
    (* Start the typing session *)
    Session.start_session lesson
  | _ ->
    Printf.eprintf "Usage: %s <filename>\n" Sys.argv.(0);
    exit 1
;;

let () = main ()
