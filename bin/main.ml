(* Inspired by https://github.com/leostera/minttea/tree/main/examples/views *)

open Minttea
open Tritip
open Tritip.Types

let init _ = Command.Noop
let initial_model = { quit = false; section = Menu_screen Types.initial_menu }

exception Exit

let update event model =
  try
    if event = Event.KeyDown Escape
    then raise Exit
    else (
      let (section : section), cmd =
        match model.section with
        | Session_screen _ -> Session.update event model.section
        | Menu_screen _ -> Menu.update event model.section
      in
      { model with section }, cmd)
  with
  | Exit -> { model with quit = true }, Command.Quit
;;

let view model =
  if model.quit
  then "Bye 👋"
  else (
    match model.section with
    | Session_screen screen -> Session.view screen
    | Menu_screen screen -> Menu.view screen)
;;

let load_file_into_session file_path =
  let content = Screens.load_content file_path in
  { quit = false; section = Session_screen { content; position = 0; last_correct = 0 } }
;;

let main () =
  match Sys.argv with
  | [| _; file_path |] ->
    Minttea.app ~init ~update ~view ()
    |> Minttea.start ~initial_model:(load_file_into_session file_path)
  | _ -> Minttea.app ~init ~update ~view () |> Minttea.start ~initial_model
;;

(* let main () = Minttea.app ~init ~update ~view () |> Minttea.start ~initial_model *)
let () = main ()
