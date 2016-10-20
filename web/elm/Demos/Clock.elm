{-
   **Clock Demo**

   Simple clock demo using the Time package and subscriptions. Displays an SVG
   circle and then uses Time to move the line for the clock's second hand.
-}


module Clock exposing (..)

import Html.App as App
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Time exposing (Time, second)


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
    Time


init : ( Model, Cmd Msg )
init =
    ( 0, Cmd.none )



-- UPDATE


type Msg
    = Tick Time
    | ResetClock


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick newTime ->
            ( newTime, Cmd.none )

        ResetClock ->
            ( 0, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    let
        angle =
            turns (Time.inMinutes model)

        handX =
            toString (50 + 40 * cos angle)

        handY =
            toString (50 + 40 * sin angle)
    in
        div
            [ Html.Attributes.style
                [ ( "font-family", "Helvetica" )
                , ( "font-size", "40px" )
                , ( "margin-left", "40px" )
                ]
            ]
            [ h1 [] [ Html.text "Clock" ]
            , button [ onClick ResetClock ] [ Html.text "Reset Clock" ]
            , Svg.svg
                [ Html.Attributes.style
                    [ ( "margin", "-40px 0 40px -100px" )
                    ]
                , viewBox "0 0 100 100"
                , Svg.Attributes.width "300px"
                ]
                [ circle [ cx "50", cy "50", r "45", fill "#0B79CE" ] []
                , line [ x1 "50", y1 "50", x2 handX, y2 handY, stroke "#023963" ] []
                ]
            ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every second Tick
