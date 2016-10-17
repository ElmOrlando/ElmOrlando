{-
   **UfoLanding Demo**

   Uses SVG and Time to display a small UFO image descending from the top of the
   screen to the ground. Example of using a conditional and let expression.
-}


module UfoLanding exposing (..)

import Html.App as App
import Html exposing (..)
import Html.Attributes exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Time exposing (..)


-- MAIN


main : Program Never
main =
    App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    Int


init : ( Model, Cmd Msg )
init =
    ( 0, Cmd.none )



-- UPDATE


type Msg
    = Tick Time


update : Msg -> Model -> ( Int, Cmd Msg )
update msg model =
    case msg of
        Tick newTime ->
            ( model + 1, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    let
        position =
            if model > 325 then
                toString 325
            else
                toString model
    in
        Svg.svg
            [ Svg.Attributes.version "1.1"
            , Svg.Attributes.width "840"
            , Svg.Attributes.height "525"
            , Svg.Attributes.viewBox ("0 0 840 525")
            , Html.Attributes.style [ ( "background-color", "black" ) ]
            ]
            [ Svg.rect
                [ Svg.Attributes.class "ground"
                , Svg.Attributes.fill "darkgreen"
                , Svg.Attributes.x "0"
                , Svg.Attributes.y "425"
                , Svg.Attributes.width "840"
                , Svg.Attributes.height "100"
                ]
                []
            , Svg.image
                [ Svg.Attributes.xlinkHref "/images/ufo.png"
                , Svg.Attributes.x "370"
                , Svg.Attributes.y position
                , Svg.Attributes.width "100"
                , Svg.Attributes.height "100"
                ]
                []
            ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every millisecond Tick
