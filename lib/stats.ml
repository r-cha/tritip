let update_stats (session : Types.session) user_input =
  let rec loop correct incorrect backspaces i =
    if i >= String.length user_input
    then correct, incorrect, backspaces
    else (
      let user_char = user_input.[i] in
      let lesson_char =
        session.lesson.Lesson.content.[session.lesson.Lesson.current_position + i]
      in
      if user_char = lesson_char
      then loop (correct + 1) incorrect backspaces (i + 1)
      else if user_char = '\b'
      then loop correct incorrect (backspaces + 1) (max (i - 1) 0)
      else loop correct (incorrect + 1) backspaces (i + 1))
  in
  loop 0 0 0 0
;;

let calculate_wpm (session : Types.session) end_time =
  let elapsed_time = end_time -. session.start_time in
  let num_chars = session.correct_keystrokes + session.incorrect_keystrokes in
  let num_words = num_chars / 5 in
  let minutes = elapsed_time /. 60.0 in
  float_of_int num_words /. minutes
;;
