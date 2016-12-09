{-
   **MouseFollow Demo**

   This program provides an example of subscriptions in Elm. This requires us to
   use App.program instead of App.beginnerProgram, so the first half of the
   steps below involve making that transformation. In the second half, we add
   subscriptions for mouse movement and keyboard down-presses. The responses to
   these messages are simple but fun!

   The following instructions begin from the ListCreator demo as a base.

   ## Configuration

   - [x] In terminal, run `elm package install elm-lang/mouse`
   - [x] Also run `elm package install elm-lang/keyboard`

   ## Setup

   - [x] Rename the module MouseFollow
   - [x] Import Mouse and Keyboard
   - [x] In the definition of `main`, change `App.beginnerProgram` to `App.program`
   - [x] In the argument of `App.program`, change `model = model` to `init = init`
   - [x] Add `subscriptions = subscriptions` to the argument of `App.program`

   ## Init Stub

   - [x] Below the model, add a new *type declaration* for `init`
     - We want `init` to be a tuple containing a `Model` and a `Cmd Msg`
   - [x] Define `init` to be a tuple containing `model` and `Cmd.none`

   ## Subscriptions Stub

   - [x] Below `update`, add a new *type declaration* for `subscriptions`
     - We want `subscriptions` to accept a `Model` and return a `Sub Msg`
   - [x] Define `subscriptions` to take an argument `model` and return `Sub.none`

   ## Update Stub

   - [x] Remove `DisplayToggle` from the *type declaration* of `Msg`
   - [x] Also remove the `DisplayToggle` case from the definition of `update`
   - [x] Change the *type declaration* of `update` to return a tuple containing a `Model` and a `Cmd Msg`
   - [x] In the `NoOp` case of `update`, return a tuple containing `model` and `Cmd.none`

   ## View Stub

   - [x] Remove `viewListItem` and its *type declaration*
   - [x] In the `view`, output an empty `div`

   ## Model

   - [x] Change the *type declaration* of `model`
     - Remove the current properties
     - Add `x` and `y` as integers
     - Add `code` as a string
   - [x] Change the definition of `model`
     - Set `x` and `y` to be zero
     - Set `code` to be the string containing the number one

   ## View

   - [x] Import `Html.Attributes` exposing `(..)`
   - [x] Style the `div` in the view:
     - Give it a `1px` black border
     - Set the `display` to `inline-block`
     - Set its `position` to `absolute`
     - Give it `10px` of `padding`
   - [x] Give it some dynamic features:
     - Set the `left` positioning to `x`
     - Set the `top` positioning to `y`
     - Use `code` as the contents

   ## Update

   - [x] Add `MouseMsg` and `KeyMsg` to the *type declaration* of `Msg`
     - `MouseMsg` takes an argument of type `Mouse.Position`
     - `KeyMsg` takes an argument of type `Keyboard.KeyCode`
   - [x] Add `MouseMsg` to the `update` case with an argument named `position`:
     - Change `x` to `position.x`
     - Change `y` to `position.y`
     - Include `Cmd.none` in the returned tuple
   - [x] Add `KeyMsg` to the `update` case with an argument named `keycode`:
     - Change `code` on the model to the string version of `keycode`
     - Include `Cmd.none` in the returned tuple

   ## Subscriptions

   - [x] Replace `Sub.none` with `Sub.batch`, which takes a list as its argument
   - [x] Add `Mouse.moves` to the list, with `MouseMsg` as its argument
   - [x] Add `Keyboard.downs` to the list, with `KeyMsg` as its argument

-}


module MouseFollow exposing (..)

import Html.App as App
import Html exposing (..)
import Html.Attributes exposing (..)
import Mouse
import Keyboard


-- INIT


init : ( Model, Cmd Msg )
init =
    ( model
    , Cmd.none
    )



-- MODEL


type alias Model =
    { x : Int
    , y : Int
    , code : String
    }


model : Model
model =
    { x = 0
    , y = 0
    , code = "1"
    }



-- UPDATE


type Msg
    = NoOp
    | MouseMsg Mouse.Position
    | KeyMsg Keyboard.KeyCode


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        MouseMsg position ->
            ( { model | x = position.x, y = position.y }, Cmd.none )

        KeyMsg keycode ->
            ( { model | code = toString keycode }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Mouse.moves MouseMsg
        , Keyboard.downs KeyMsg
        ]



-- VIEW


view : Model -> Html Msg
view model =
    let
        x =
            toString model.x ++ "px"

        y =
            toString model.y ++ "px"
    in
        div
            [ style
                [ ( "border", "1px solid black" )
                , ( "display", "inline-block" )
                , ( "position", "absolute" )
                , ( "padding", "10px" )
                , ( "left", x )
                , ( "top", y )
                ]
            ]
            [ text model.code ]



-- MAIN


main : Program Never
main =
    App.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
