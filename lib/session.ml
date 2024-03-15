open Minttea
open Leaves
open Types
open Display

let update (event : Event.t) (screen : section) =
  match screen with
  | Menu_screen _ -> raise Invalid_update
  | Session_screen model ->
    let correct_key = String.sub model.content model.position 1 in
    let forward = model.position + 1 in
    (match event with
     | Event.KeyDown k ->
       (match k with
        | Backspace ->
          let new_position = max 0 (model.position - 1) in
          Session_screen { model with position = new_position }, Command.Noop
        | Space when correct_key = " " ->
          ( Session_screen { model with position = forward; last_correct = forward }
          , Command.Noop )
        | Enter when correct_key = "\n" ->
          ( Session_screen { model with position = forward; last_correct = forward }
          , Command.Noop )
        | Key l when l = correct_key ->
          ( Session_screen { model with position = forward; last_correct = forward }
          , Command.Noop )
        | _ ->
          ( Session_screen
              { model with
                position = forward
              ; last_correct = min model.last_correct model.position
              }
          , Command.Noop ))
     | _ -> Session_screen model, Command.Noop)
;;

let view screen =
  let before_cursor = String.sub screen.content 0 screen.position in
  let style =
    if screen.last_correct >= screen.position
    then Spices.(default |> fg (color "#06FFB7") |> reverse true)
    else Spices.(default |> fg (color "#FF06B7") |> reverse true)
  in
  let cursor_content =
    match String.sub screen.content screen.position 1 with
    | "\n" -> "¶\n"
    | c -> c
  in
  let cursor = Cursor.view (Cursor.make ~style ()) ~text_style:style cursor_content in
  let after_cursor =
    String.sub
      screen.content
      (screen.position + 1)
      (String.length screen.content - screen.position - 1)
  in
  Format.sprintf
    {|  Type this: %s
%s%s%s|}
    (highlight "Last correct:%d Position:%d" screen.last_correct screen.position)
    before_cursor
    cursor
    (subtle "%s" after_cursor)
;;
