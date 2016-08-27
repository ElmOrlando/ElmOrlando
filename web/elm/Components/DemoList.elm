module Components.DemoList exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)


-- VIEW


view : Html a
view =
    div [ class "demo-list" ]
        [ h2 [] [ text "Demo List" ]
        , ul [] renderDemos
        ]


renderDemos : List (Html a)
renderDemos =
    [ li [] [ text "Demo 1" ]
    , li [] [ text "Demo 2" ]
    , li [] [ text "Demo 3" ]
    ]
