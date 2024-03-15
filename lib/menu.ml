open Minttea
open Types
open Display

let initial_model =
  let files =
    Sys.readdir "."
    |> Array.to_list
    |> List.filter (fun file -> not (Sys.is_directory file))
  in
  { selected = 0; options = files }
;;

let select_next (screen : menu_model) =
  let option_count = List.length screen.options in
  let selected = screen.selected + 1 in
  let selected = if selected >= option_count then 0 else selected in
  { screen with selected }
;;

let select_prev screen =
  let option_count = List.length screen.options in
  let selected = screen.selected - 1 in
  let selected = if selected < 0 then option_count - 1 else selected in
  { screen with selected }
;;

let update event screen =
  match screen with
  | Session_screen _ -> raise Invalid_update
  | Menu_screen screen ->
    (match event with
     | Event.KeyDown Enter -> Screens.transition (Menu_screen screen), Command.Noop
     | Event.KeyDown (Key "j" | Down) -> Menu_screen (select_next screen), Command.Noop
     | Event.KeyDown (Key "k" | Up) -> Menu_screen (select_prev screen), Command.Noop
     | _ -> Menu_screen screen, Command.Noop)
;;

let view screen =
  let choices =
    List.mapi
      (fun idx choice ->
        let checked = idx = screen.selected in
        let checkbox = Leaves.Forms.checkbox ~checked choice in
        if checked then highlight "%s" checkbox else checkbox)
      screen.options
    |> String.concat "\n"
  in
  let help =
    subtle "j/k: select" ^ dot ^ subtle "enter: choose" ^ dot ^ subtle "esc: quit"
  in
  Format.sprintf {|Choose a file to practice your typing on:

%s

%s
|} choices help
;;
