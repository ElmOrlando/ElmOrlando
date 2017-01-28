{-
   **HelloWorld Demo**

   Example of Elm Architecture to demonstrate Model, Update, and View. User
   can update the text content with a form field, and a log of non-destructive
   content changes will be displayed in the dev console.
-}


module HelloWorld exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Debug


-- MAIN


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = update
        }



-- MODEL


type alias Model =
    { content : String }


model : Model
model =
    { content = "" }



-- UPDATE


type Msg
    = Change String
    | Reset


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change newContent ->
            Debug.log "content"
                { model | content = newContent }

        Reset ->
            { model | content = "" }



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
        [ h1 [] [ text ("Hello  " ++ model.content) ]
        , input [ type_ "text", placeholder "Enter value...", onInput Change ] []
        , button [ onClick Reset ] [ text "Reset" ]
        ]
