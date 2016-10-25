{-
   **GraphicsStamps Demo**

      Uses the Collage package along with the Mouse package to create shapes and
      move them around on the screen. Definitely sign up at DailyDrip.com for an
      in-depth lesson about how to do this!

-}


module GraphicsStamps exposing (..)

import Color exposing (..)
import Collage exposing (..)
import Element exposing (..)
import Html.App as App
import Html exposing (..)
import Html.Events exposing (onClick)
import Keyboard
import Mouse


-- MAIN


main : Program Never
main =
    App.program
        { init = ( model, Cmd.none )
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


type alias Model =
    { stamps : List Stamp
    , shift : Bool
    }


type alias Position =
    ( Int, Int )


type alias Stamp =
    { position : ( Int, Int )
    , shape : Shape
    }


type Shape
    = Pentagon
    | Circle


model : Model
model =
    { stamps = []
    , shift = False
    }



-- UPDATE


type Msg
    = AddClick Position
    | HandleShift Bool
    | ClearScreen
    | NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AddClick pos ->
            let
                newStamp =
                    if model.shift then
                        Stamp pos Pentagon
                    else
                        Stamp pos Circle
            in
                { model | stamps = newStamp :: model.stamps } ! []

        HandleShift pressed ->
            { model | shift = pressed } ! []

        ClearScreen ->
            { model | stamps = [] } ! []

        NoOp ->
            model ! []



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Mouse.clicks (\{ x, y } -> AddClick ( x, y ))
        , Keyboard.downs mapKeyDown
        , Keyboard.ups mapKeyUp
        ]



-- KEYBOARD


mapKeyDown : Int -> Msg
mapKeyDown keyCode =
    case keyCode of
        16 ->
            HandleShift True

        _ ->
            NoOp


mapKeyUp : Int -> Msg
mapKeyUp keyCode =
    case keyCode of
        16 ->
            HandleShift False

        _ ->
            NoOp



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ viewCollage model
        , clearButton
        ]


viewCollage : Model -> Html Msg
viewCollage model =
    let
        theGroup =
            group (List.map drawStamp model.stamps)

        originGroup =
            move ( -400, 400 ) theGroup
    in
        collage 800
            800
            [ originGroup ]
            |> Element.toHtml


clearButton : Html Msg
clearButton =
    button [ onClick ClearScreen ] [ Html.text "Clear Screen" ]


drawStamp : Stamp -> Form
drawStamp stamp =
    let
        ( x, y ) =
            stamp.position

        shape =
            case stamp.shape of
                Pentagon ->
                    ngon 5 50

                Circle ->
                    circle 50
    in
        shape
            |> filled red
            |> move ( toFloat (x), toFloat (-y) )


clicks : List ( Int, Int )
clicks =
    []
