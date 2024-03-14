let start_session lesson =
  let session : Types.session =
    { lesson
    ; correct_keystrokes = 0
    ; incorrect_keystrokes = 0
    ; backspaces = 0
    ; start_time = Unix.gettimeofday ()
    }
  in
  let rec loop session input_str =
    let portion_size = 20 in
    let portion = Lesson.get_current_portion lesson ~portion_size in
    Display.render_lesson portion input_str;
    match Input.read_char () with
    | exception End_of_file -> session
    | '\r' -> session
    | ch ->
      let input_str =
        if ch = '\b'
        then String.sub input_str 0 (max (String.length input_str - 1) 0)
        else input_str ^ String.make 1 ch
      in
      let correct, incorrect, backspaces = Stats.update_stats session input_str in
      session.correct_keystrokes <- correct;
      session.incorrect_keystrokes <- incorrect;
      session.backspaces <- backspaces;
      if String.length input_str >= String.length portion
      then (
        let () = Lesson.advance_position session.lesson (String.length input_str) in
        if Lesson.has_more_content session.lesson then loop session "" else session)
      else loop session input_str
  in
  let final_session = loop session "" in
  let end_time = Unix.gettimeofday () in
  let wpm = Stats.calculate_wpm final_session end_time in
  Display.render_stats final_session wpm;
  ()
;;
