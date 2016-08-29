module Components.ResourceList exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)


-- VIEW


view : Html a
view =
    div [ class "resources" ]
        [ h2 [] [ text "Resources" ]
        ]
