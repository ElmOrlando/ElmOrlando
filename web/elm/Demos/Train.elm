{-
   **Train Demo**

   Demo using keyboard input to move a small train image from left to right.
-}


module Train exposing (..)

import Html.App as App
import Html exposing (..)
import Html.Attributes exposing (..)
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
            ( model - 20, Cmd.none )

        ArrowRight ->
            ( model + 20, Cmd.none )

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
                , Svg.Attributes.fill "lightgray"
                , Svg.Attributes.x "0"
                , Svg.Attributes.y "425"
                , Svg.Attributes.width "840"
                , Svg.Attributes.height "100"
                ]
                []
            , Svg.image
                [ Svg.Attributes.xlinkHref "/images/train.png"
                , Svg.Attributes.x position
                , Svg.Attributes.y "335"
                , Svg.Attributes.width "100"
                , Svg.Attributes.height "100"
                ]
                []
            ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Keyboard.downs KeyDown
        , Keyboard.ups KeyUp
        ]
