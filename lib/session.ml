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
          ( Session_screen
              { model with
                position = new_position
              ; last_correct = min model.last_correct new_position
              }
          , Command.Noop )
        | _ when model.position > model.last_correct ->
          (* any key when already incorrect *)
          Session_screen { model with position = forward }, Command.Noop
        (* CORRECT KEYS *)
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
          (* FIRST INCORRECT KEY *)
          (* Move the cursor forward, but mark that they're wrong. *)
          ( Session_screen
              { model with
                position = forward
              ; last_correct = min model.last_correct model.position
              }
          , Command.Noop ))
     | _ -> Session_screen model, Command.Noop)
;;

let view screen =
  let in_error = screen.last_correct < screen.position in
  let completed_segment = String.sub screen.content 0 screen.last_correct in
  let central_segment =
    if in_error
    then (
      let incorrect_character =
        error_reverse "%s" (String.sub screen.content screen.last_correct 1)
      in
      let difference =
        String.sub
          screen.content
          (screen.last_correct + 1)
          (screen.position - screen.last_correct - 1)
      in
      incorrect_character ^ difference)
    else ""
  in
  let style =
    if in_error
    then Spices.(default |> fg (color "#FF06B7") |> reverse true)
    else Spices.(default |> fg (color "#06FFB7") |> reverse true)
  in
  let cursor_content =
    (* The cursor is usually just the cursor, but newlines need newlines and errors need backspace. *)
    let beneath_cursor = String.sub screen.content screen.position 1 in
    let cursor_content =
      if in_error
      then "⇽"
      else (
        match beneath_cursor with
        | "\n" -> "⏎"
        | c -> c)
    in
    let suffix =
      match beneath_cursor with
      | "\n" -> "\n"
      | _ -> ""
    in
    cursor_content ^ suffix
  in
  let cursor = Cursor.view (Cursor.make ~style ()) ~text_style:style cursor_content in
  let after_cursor =
    String.sub
      screen.content
      (screen.position + 1)
      (String.length screen.content - screen.position - 1)
  in
  Format.sprintf
    {|  %s
%s%s%s%s|}
    (highlight
       "Esc to quit. Last correct:%d Position:%d"
       screen.last_correct
       screen.position)
    completed_segment
    central_segment
    cursor
    (subtle "%s" after_cursor)
;;
