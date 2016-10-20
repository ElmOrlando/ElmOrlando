{-
   **CalorieCounter Demo**

   Simple beginner program example to track calories. For more about this demo,
   check out the amazing Elm for Beginners course at
   http://courses.knowthen.com/courses/elm-for-beginners.
-}


module CalorieCounter exposing (..)

import Html.App as App
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String


-- MAIN


main : Program Never
main =
    App.beginnerProgram
        { model = initModel
        , view = view
        , update = update
        }



-- MODEL


type alias Model =
    { calories : Int
    , input : Int
    , error : Maybe String
    }


initModel : Model
initModel =
    { calories = 0
    , input = 0
    , error = Nothing
    }



-- UPDATE


type Msg
    = AddCalories
    | Input String
    | Clear


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddCalories ->
            { model
                | calories = model.calories + model.input
                , input = 0
            }

        Input i ->
            case String.toInt i of
                Ok input ->
                    { model
                        | input = input
                        , error = Nothing
                    }

                Err err ->
                    { model
                        | input = 0
                        , error = Just err
                    }

        Clear ->
            initModel



-- VIEW


view : Model -> Html Msg
view model =
    let
        header =
            ("Calories: " ++ (toString model.calories))
    in
        div
            [ style
                [ ( "font-family", "Helvetica" )
                , ( "font-size", "40px" )
                , ( "margin-left", "40px" )
                ]
            ]
            [ h1 [] [ text header ]
            , input
                [ type' "text "
                , placeholder "Calories..."
                , onInput Input
                , value
                    (if model.input == 0 then
                        ""
                     else
                        toString model.input
                    )
                ]
                []
            , div [] [ text (Maybe.withDefault "" model.error) ]
            , button [ onClick AddCalories ] [ text "Add Calories" ]
            , button [ onClick Clear ] [ text "Clear" ]
            ]
