module Components.DemoList exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)


view : Html a
view =
    div [ class "demo-list" ]
        [ h2 [] [ text "Demos" ]
        , ul []
            [ li [] [ text "Demo 1" ]
            , li [] [ text "Demo 2" ]
            , li [] [ text "Demo 3" ]
            ]
        ]
