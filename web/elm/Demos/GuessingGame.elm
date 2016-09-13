{-
   **Guessing Game Demo**

   Example of a binary search algorithm using a guessing game where the user
   selects a number between 1 and 100. The game makes guesses and the user can
   indicate whether the number is higher or lower until the result is found.
-}


module Main exposing (..)

import Html.App as App
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- MAIN


main : Program Never
main =
    App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { guess : Int
    , lower : Int
    , upper : Int
    }


init : ( Model, Cmd Msg )
init =
    ( { guess = 50
      , lower = 1
      , upper = 100
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = Guess
    | Higher
    | Lower
    | Reset


update : Msg -> Model -> ( Model, Cmd a )
update msg model =
    case msg of
        Guess ->
            ( { model
                | guess = floor ((toFloat (model.lower + model.upper)) / 2)
              }
            , Cmd.none
            )

        Higher ->
            ( { model
                | lower = Basics.min model.upper (model.guess + 1)
              }
            , Cmd.none
            )

        Lower ->
            ( { model
                | upper = Basics.max model.lower (model.guess - 1)
              }
            , Cmd.none
            )

        Reset ->
            ( { model
                | lower = 1
                , upper = 100
                , guess = 50
              }
            , Cmd.none
            )



-- VIEW


view : Model -> Html Msg
view model =
    div
        [ style
            [ ( "font-family", "Helvetica" )
            , ( "font-size", "40px" )
            , ( "margin-left", "40px" )
            ]
        ]
        [ h1 [] [ text "Guessing Game" ]
        , p [] [ text "Think of a number between 1 and 100." ]
        , p [] [ text ("I currently know it's between " ++ (toString model.lower) ++ " and " ++ (toString model.upper) ++ ".") ]
        , p [] [ text ("Is it " ++ (toString model.guess) ++ "?") ]
        , button [ onClick Higher ] [ text "It's Higher" ]
        , button [ onClick Lower ] [ text "It's Lower" ]
        , button [ onClick Guess ] [ text "Make a Guess" ]
        , button [ onClick Reset ] [ text "Restart" ]
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
