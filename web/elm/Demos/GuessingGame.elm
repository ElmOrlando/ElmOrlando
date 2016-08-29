-- Guessing Game
-- The user selects a number in a specified range, and then the game makes
-- guesses until the user's number is found.


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
    div [ class "guessing-game" ]
        [ h1 [] [ text "Guessing Game" ]
        , p [] [ text ("Think of a number (but don't tell me what it is yet!) between " ++ (toString model.lower) ++ " and " ++ (toString model.upper) ++ ".") ]
        , p [] [ text ("Is it " ++ (toString model.guess) ++ "?") ]
        , button [ onClick Guess ] [ text "Guess" ]
        , button [ onClick Higher ] [ text "Higher" ]
        , button [ onClick Lower ] [ text "Lower" ]
        , button [ onClick Reset ] [ text "Reset" ]
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
