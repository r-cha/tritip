type menu_model =
  { selected : int
  ; options : string list
  }

let initial_menu =
  let files =
    Sys.readdir "."
    |> Array.to_list
    |> List.filter (fun file -> not (Sys.is_directory file))
  in
  { selected = 0; options = files }
;;

type session_model =
  { content : string
  ; position : int
  ; last_correct : int
  }

type section =
  | Menu_screen of menu_model
  | Session_screen of session_model

type app_model =
  { quit : bool
  ; section : section
  }

exception Invalid_transition
exception Invalid_update
