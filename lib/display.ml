let dot = Spices.(default |> fg (color "236") |> build) " • "
let subtle fmt = Spices.(default |> fg (color "241") |> build) fmt
let keyword fmt = Spices.(default |> fg (color "211") |> build) fmt
let highlight fmt = Spices.(default |> fg (color "#FF06B7") |> build) fmt
