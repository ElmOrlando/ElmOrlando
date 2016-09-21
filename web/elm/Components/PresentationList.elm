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
            [ li [] [ a [ href "http://prezi.com/wofdk8e6uuy3" ] [ text "Getting to Know Elm" ] ]
            ]
        ]
