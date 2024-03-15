open Types

let transition screen =
  match screen with
  | Menu_screen menu ->
    let filename = List.nth menu.options menu.selected in
    let content = In_channel.with_open_text filename In_channel.input_all in
    Session_screen { content; position = 0; last_correct = 0 }
  | Session_screen _ -> Menu_screen initial_menu
;;
