{-
   **Key Demo**

   Maps the left and right arrow keys to allow for user interaction with demos.
-}


module Key exposing (..)


type Key
    = ArrowLeft
    | ArrowRight
    | Unknown


fromCode : Int -> Key
fromCode keyCode =
    case keyCode of
        37 ->
            ArrowLeft

        39 ->
            ArrowRight

        _ ->
            Unknown
