module Components.PresentationList exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)


-- VIEW


view : Html a
view =
    div [ class "presentations" ]
        [ h2 [] [ text "Presentations" ]
        , h3 [] [ text "September 2016" ]
        , ul []
            [ li [] [ i [] [ text "Coming Soon" ] ]
            ]
        ]
