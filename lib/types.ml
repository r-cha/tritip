(* types.ml *)

type session =
  { lesson : Lesson.lesson
  ; mutable correct_keystrokes : int
  ; mutable incorrect_keystrokes : int
  ; mutable backspaces : int
  ; mutable start_time : float
  }
