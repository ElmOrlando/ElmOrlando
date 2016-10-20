module Components.DemoShow exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


-- MODEL


type alias Demo =
    { name : String
    , liveDemoUrl : String
    , sourceCodeUrl : String
    }



-- UPDATE


type Msg
    = NoOp



-- VIEW


view : Demo -> Html Msg
view model =
    div []
        [ h3 [] [ text model.name ]
        , ul [ class "demo-list-item" ]
            [ li []
                [ a [ href model.liveDemoUrl ] [ text "Live Demo" ]
                ]
            , li []
                [ a [ href model.sourceCodeUrl ] [ text "Source Code" ]
                ]
            ]
        ]
