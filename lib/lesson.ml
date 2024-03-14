(* lesson.ml *)

type lesson =
  { content : string
  ; mutable current_position : int
  }

let load_file filename =
  try
    let content = In_channel.with_open_text filename In_channel.input_all in
    { content; current_position = 0 }
  with
  | Sys_error _ ->
    Printf.eprintf "Error: Unable to open file '%s'\n" filename;
    exit 1
;;

let get_current_portion lesson ~portion_size =
  let start_index = lesson.current_position in
  let end_index = min (start_index + portion_size) (String.length lesson.content) in
  String.sub lesson.content start_index (end_index - start_index)
;;

let advance_position lesson portion_size =
  lesson.current_position <- lesson.current_position + portion_size
;;

let has_more_content lesson = lesson.current_position < String.length lesson.content
