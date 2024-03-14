open Minttea
open Types

let update (_event : Event.t) (model : section) = model, Command.Noop
let view screen = screen.content
