module Main exposing (..)

import Html.App as App
import Html exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Keyboard exposing (KeyCode)
import Key exposing (..)


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
    ( 50, Cmd.none )



-- UPDATE


type Msg
    = KeyDown KeyCode
    | KeyUp KeyCode


update : Msg -> Model -> ( Int, Cmd Msg )
update msg model =
    case msg of
        KeyDown keyCode ->
            (keyDown keyCode model)

        KeyUp keyCode ->
            (keyUp keyCode model)


keyDown : KeyCode -> Model -> ( Int, Cmd Msg )
keyDown keyCode model =
    case Key.fromCode keyCode of
        ArrowLeft ->
            ( model - 10, Cmd.none )

        ArrowRight ->
            ( model + 10, Cmd.none )

        _ ->
            ( model, Cmd.none )


keyUp : KeyCode -> Model -> ( Int, Cmd Msg )
keyUp keyCode model =
    case Key.fromCode keyCode of
        ArrowLeft ->
            ( model + 0, Cmd.none )

        ArrowRight ->
            ( model + 0, Cmd.none )

        _ ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    let
        position =
            toString model

        message =
            if position == (toString 260) then
                "CITY of ElmLANDO"
            else
                "CITY of ORLANDO"
    in
        Svg.svg
            [ Svg.Attributes.version "1.1"
            , Svg.Attributes.width "580"
            , Svg.Attributes.height "360"
            , Svg.Attributes.viewBox ("0 0 580 360")
            ]
            [ Svg.image
                [ Svg.Attributes.xlinkHref "/images/city_of_orlando.png"
                , Svg.Attributes.x "0"
                , Svg.Attributes.y "0"
                , Svg.Attributes.width "580"
                , Svg.Attributes.height "360"
                ]
                []
            , Svg.image
                [ Svg.Attributes.xlinkHref "/images/elm.png"
                , Svg.Attributes.x position
                , Svg.Attributes.y "0"
                , Svg.Attributes.width "50"
                , Svg.Attributes.height "50"
                ]
                []
            , Svg.text'
                [ Svg.Attributes.x "115"
                , Svg.Attributes.y "295"
                , Svg.Attributes.fontFamily "Baumans, cursive"
                , Svg.Attributes.fontWeight "bold"
                , Svg.Attributes.fontSize "38px"
                , Svg.Attributes.letterSpacing "3.4px"
                , Svg.Attributes.fill "#2a2828"
                ]
                [ Svg.text message ]
            ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Keyboard.downs KeyDown
        , Keyboard.ups KeyUp
        ]
