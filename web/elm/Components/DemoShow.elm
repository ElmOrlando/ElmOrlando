module Components.DemoShow exposing (..)

import Components.Demo as Demo
import Html exposing (..)
import Html.Attributes exposing (..)


-- UPDATE


type Msg
    = NoOp



-- VIEW


view : Demo.Model -> Html Msg
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
