module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Components.DemoList as DemoList


main : Html a
main =
    div [ class "elm-app" ] [ DemoList.view ]
