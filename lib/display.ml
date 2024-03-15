let dot = Spices.(default |> fg (color "236") |> build) " • "
let subtle fmt = Spices.(default |> fg (color "241") |> build) fmt
let keyword fmt = Spices.(default |> fg (color "211") |> build) fmt
let highlight fmt = Spices.(default |> fg (color "#FF06B7") |> build) fmt
let error fmt = Spices.(default |> fg (color "196") |> build) fmt
let error_reverse fmt = Spices.(default |> fg (color "196") |> reverse true |> build) fmt
