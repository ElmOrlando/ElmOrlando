{-
   **ElmMario Demo**

   Mario mini game using input from both the keyboard and mouse to reach a "win"
   state. The user can enter their name in a form field, click a button to reach
   the target score, and then use the keyboard arrows to move the character to
   the right position to trigger the completion state.
-}


module Main exposing (..)

import Html.App as App
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Keyboard exposing (KeyCode)
import Key exposing (..)
import Time exposing (..)


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
    { name : String
    , score : Int
    , characterPosition : Int
    , flagPosition : Int
    }


init : ( Model, Cmd Msg )
init =
    ( { name = ""
      , score = 0
      , characterPosition = 20
      , flagPosition = 275
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = Name String
    | IncrementScore
    | ResetScore
    | KeyDown KeyCode
    | KeyUp KeyCode
    | Tick Time


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Name name ->
            Debug.log "Debug"
                ( { model | name = name }, Cmd.none )

        IncrementScore ->
            Debug.log "Debug"
                ( { model | score = model.score + 1 }, Cmd.none )

        ResetScore ->
            Debug.log "Debug"
                ( { model | score = 0 }, Cmd.none )

        KeyDown keyCode ->
            Debug.log "Debug"
                (keyDown keyCode model)

        KeyUp keyCode ->
            Debug.log "Debug"
                (keyUp keyCode model)

        Tick newTime ->
            if model.flagPosition < 40 then
                ( { model | flagPosition = 40 }, Cmd.none )
            else if (model.name /= "") && (model.score >= 1) && (model.characterPosition >= 400) then
                ( { model | flagPosition = model.flagPosition - 1 }, Cmd.none )
            else
                ( { model | flagPosition = 275 }, Cmd.none )


keyDown : KeyCode -> Model -> ( Model, Cmd Msg )
keyDown keyCode model =
    case Key.fromCode keyCode of
        ArrowLeft ->
            ( { model | characterPosition = model.characterPosition - 15 }, Cmd.none )

        ArrowRight ->
            ( { model | characterPosition = model.characterPosition + 15 }, Cmd.none )

        _ ->
            ( model, Cmd.none )


keyUp : KeyCode -> Model -> ( Model, Cmd Msg )
keyUp keyCode model =
    case Key.fromCode keyCode of
        ArrowLeft ->
            ( { model | characterPosition = model.characterPosition }, Cmd.none )

        ArrowRight ->
            ( { model | characterPosition = model.characterPosition }, Cmd.none )

        _ ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    let
        name =
            ("Name: " ++ model.name)

        score =
            ("Score: " ++ (toString model.score))
    in
        div
            [ Html.Attributes.style
                [ ( "background-color", "#4b7cfb" )
                , ( "color", "white" )
                , ( "width", "840" )
                , ( "height", "545" )
                , ( "position", "absolute" )
                , ( "font-family", "Helvetica" )
                ]
            ]
            [ viewDivHeader
            , viewDivName name
            , viewDivScore score
            , viewDivNameInput
            , viewDivResetButton
            , viewSuccess model
            , viewGame model
            ]


viewDivHeader : Html a
viewDivHeader =
    h1
        [ Html.Attributes.style
            [ ( "font-size", "80px" )
            , ( "margin-left", "40px" )
            ]
        ]
        [ Html.text "ElmMario" ]


viewDivName : String -> Html a
viewDivName name =
    p
        [ Html.Attributes.style
            [ ( "font-size", "20px" )
            , ( "margin-left", "40px" )
            ]
        ]
        [ Html.text name ]


viewDivScore : String -> Html a
viewDivScore score =
    p
        [ Html.Attributes.style
            [ ( "font-size", "20px" )
            , ( "margin-left", "40px" )
            ]
        ]
        [ Html.text score ]


viewDivNameInput : Html Msg
viewDivNameInput =
    input
        [ Html.Attributes.style
            [ ( "margin-left", "40px" )
            ]
        , Html.Attributes.type' "text"
        , placeholder "Name"
        , onInput Name
        ]
        []


viewDivResetButton : Html Msg
viewDivResetButton =
    button [ onClick ResetScore ] [ Html.text "Reset Score" ]


viewGame : Model -> Html Msg
viewGame model =
    let
        characterPosition =
            toString model.characterPosition

        flagPosition =
            toString model.flagPosition
    in
        Svg.svg
            [ Svg.Attributes.version "1.1"
            , Svg.Attributes.x "0"
            , Svg.Attributes.y "0"
            , Svg.Attributes.width "840"
            , Svg.Attributes.height "525"
            , Svg.Attributes.viewBox "0 0 840 525"
            , Html.Attributes.style [ ( "display", "block" ) ]
            ]
            [ viewSvgDefs
            , viewSvgGround
            , viewSvgScore
            , viewSvgFlagPole
            , viewSvgElmFlag flagPosition
            , viewSvgCastle
            , viewSvgMario characterPosition
            ]


viewSvgDefs : Svg Msg
viewSvgDefs =
    defs []
        [ Svg.pattern
            [ Svg.Attributes.id "ground"
            , Svg.Attributes.patternUnits "userSpaceOnUse"
            , Svg.Attributes.width "50"
            , Svg.Attributes.height "50"
            ]
            [ image
                [ Svg.Attributes.xlinkHref "/images/ground.png"
                , Svg.Attributes.x "0"
                , Svg.Attributes.y "0"
                , Svg.Attributes.width "50"
                , Svg.Attributes.height "50"
                ]
                []
            ]
        ]


viewSvgGround : Svg Msg
viewSvgGround =
    rect
        [ Svg.Attributes.class "ground"
        , Svg.Attributes.fill "url(#ground)"
        , Svg.Attributes.x "0"
        , Svg.Attributes.y "350"
        , Svg.Attributes.width "840"
        , Svg.Attributes.height "180"
        ]
        []


viewSvgScore : Svg Msg
viewSvgScore =
    image
        [ onClick IncrementScore
        , Svg.Attributes.xlinkHref "/images/score.png"
        , Svg.Attributes.x "200"
        , Svg.Attributes.y "100"
        , Svg.Attributes.width "50"
        , Svg.Attributes.height "50"
        ]
        []


viewSvgFlagPole : Svg Msg
viewSvgFlagPole =
    image
        [ Svg.Attributes.xlinkHref "/images/flag_pole.png"
        , Svg.Attributes.x "400"
        , Svg.Attributes.y "19"
        , Svg.Attributes.width "50"
        , Svg.Attributes.height "332"
        ]
        []


viewSvgElmFlag : String -> Svg Msg
viewSvgElmFlag flagPosition =
    image
        [ Svg.Attributes.xlinkHref "/images/elm.png"
        , Svg.Attributes.x "391"
        , Svg.Attributes.y flagPosition
        , Svg.Attributes.width "40"
        , Svg.Attributes.height "40"
        ]
        []


viewSvgCastle : Svg Msg
viewSvgCastle =
    image
        [ Svg.Attributes.xlinkHref "/images/castle.png"
        , Svg.Attributes.x "480"
        , Svg.Attributes.y "-2"
        , Svg.Attributes.width "337"
        , Svg.Attributes.height "352"
        ]
        []


viewSvgMario : String -> Svg Msg
viewSvgMario characterPosition =
    image
        [ Svg.Attributes.xlinkHref "/images/mario.png"
        , Svg.Attributes.x characterPosition
        , Svg.Attributes.y "300"
        , Svg.Attributes.width "50"
        , Svg.Attributes.height "50"
        ]
        []


viewSuccess : Model -> Html msg
viewSuccess model =
    let
        message =
            if (model.name /= "") && (model.score >= 1) && (model.characterPosition >= 400) then
                "You win, " ++ model.name ++ "!"
            else
                ""
    in
        span
            [ Html.Attributes.style
                [ ( "font-size", "40px" )
                , ( "font-weight", "bold" )
                , ( "margin-left", "250px" )
                , ( "color", "#fc9434" )
                ]
            ]
            [ Html.text message ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Keyboard.downs KeyDown
        , Keyboard.ups KeyUp
        , Time.every millisecond Tick
        ]
