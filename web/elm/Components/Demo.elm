module Demo exposing (view, Model)

import Html exposing (..)
import Html.Attributes exposing (..)


-- MODEL


type alias Model =
    { name : String
    , liveDemoUrl : String
    , sourceCodeUrl : String
    }



-- VIEW


view : Model -> Html a
view model =
    span [ class "demo" ]
        [ strong [] [ text model.name ]
        , a [ href model.liveDemoUrl ] [ text "Live Demo" ]
        , a [ href model.sourceCodeUrl ] [ text "Source Code" ]
        ]
