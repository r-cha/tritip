open Types

let load_content filename =
  In_channel.with_open_text filename (fun ic ->
    let rec read_lines acc remaining_lines =
      if remaining_lines <= 0
      then List.rev acc
      else (
        match In_channel.input_line ic with
        | Some line -> read_lines (line :: acc) (remaining_lines - 1)
        | None -> List.rev acc)
    in
    read_lines [] 25 |> String.concat "\n")
;;

let transition screen =
  match screen with
  | Menu_screen menu ->
    let content = List.nth menu.options menu.selected |> load_content in
    Session_screen { content; position = 0; last_correct = 0 }
  | Session_screen _ -> Menu_screen initial_menu
;;
