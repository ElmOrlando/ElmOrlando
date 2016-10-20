module Components.ResourceList exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)


-- VIEW


view : Html a
view =
    div [ class "resources" ]
        [ h2 [] [ text "Resources" ]
        , h3 [] [ text "Books" ]
        , ul []
            [ li [] [ a [ href "http://guide.elm-lang.org" ] [ text "An Introduction to Elm" ] ]
            , li [] [ a [ href "https://raorao.gitbooks.io/elmbridge-curriculum/content" ] [ text "Elmbridge Curriculum" ] ]
            ]
        , h3 [] [ text "Courses" ]
        , ul []
            [ li [] [ a [ href "http://courses.knowthen.com/courses/elm-for-beginners" ] [ text "Elm for Beginners" ] ]
            , li [] [ a [ href "https://www.dailydrip.com/topics/elm" ] [ text "Daily Drip Elm" ] ]
            ]
        , h3 [] [ text "Community" ]
        , ul []
            [ li [] [ a [ href "http://elmlang.herokuapp.com" ] [ text "Elm Slack" ] ]
            , li [] [ a [ href "https://twitter.com/elmlang" ] [ text "Elm Twitter" ] ]
            , li [] [ a [ href "http://www.elmweekly.nl" ] [ text "Elm Weekly" ] ]
            ]
        , h3 [] [ text "Elm and Phoenix" ]
        , ul []
            [ li [] [ a [ href "https://medium.com/@diamondgfx/setting-up-elm-with-phoenix-be3a9f55bac2" ] [ text "Setting Up Elm with Phoenix" ] ]
            , li [] [ a [ href "https://medium.com/@diamondgfx/writing-a-full-site-in-phoenix-and-elm-a100804c9499" ] [ text "Writing a Full Site in Phoenix and Elm" ] ]
            , li [] [ a [ href "http://www.cultivatehq.com/posts/phoenix-elm-1" ] [ text "Phoenix with Elm" ] ]
            ]
        ]
