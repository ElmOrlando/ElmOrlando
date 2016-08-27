module Components.DemoList exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import List
import Demo


-- MODEL


demos : List Demo.Model
demos =
    [ { name = "Hello World", liveDemoUrl = "#", sourceCodeUrl = "#" }
    , { name = "Counter", liveDemoUrl = "#", sourceCodeUrl = "#" }
    , { name = "Mario", liveDemoUrl = "#", sourceCodeUrl = "#" }
    ]



-- VIEW


view : Html a
view =
    div [ class "demo-list" ]
        [ h2 [] [ text "Demo List" ]
        , ul [] renderDemos
        ]


renderDemos : List (Html a)
renderDemos =
    List.map renderDemo demos


renderDemo : Demo.Model -> Html a
renderDemo demo =
    li [] [ Demo.view demo ]
