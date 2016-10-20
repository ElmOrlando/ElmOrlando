{-
   **Counter Demo**

   Simple counter program that starts with a zero value and allows users to
   click buttons to increment, decrement, or reset the value.
-}


module Counter exposing (..)

import Html.App as App
import Html exposing (Html, button, div, h1, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)


-- MAIN


main : Program Never
main =
    App.beginnerProgram
        { model = model
        , view = view
        , update = update
        }



-- MODEL


model : Int
model =
    0



-- UPDATE


type Msg
    = Increment
    | Decrement
    | Reset


update : Msg -> Int -> Int
update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1

        Reset ->
            0



-- VIEW


view : Int -> Html Msg
view model =
    div
        [ style
            [ ( "font-family", "Helvetica" )
            , ( "font-size", "40px" )
            , ( "margin-left", "40px" )
            ]
        ]
        [ h1 [] [ text "Counter" ]
        , h1 [] [ text (toString model) ]
        , button [ onClick Decrement ] [ text "Decrement" ]
        , button [ onClick Increment ] [ text "Increment" ]
        , button [ onClick Reset ] [ text "Reset" ]
        ]
