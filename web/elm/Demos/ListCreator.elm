{-
   **ListCreator Demo**

   This file contains the results of a live collaborative coding session we had
   for our November meeting of Elm Orlando. We set out to create a simple list
   application completely from scratch and managed to get a toggle interaction
   working too.

   Here is the checklist that we used as a guide to start the project, but we
   also managed to keep things light and didn't follow it very closely during
   the live session since everyone did a fantastic job of working through the
   process of solving the problem.

   # Building a List with Elm

   ## Configuration

   - [x] Create an `elm` folder and `cd` into it.
   - [x] Install packages.
   - [x] Create initial Elm source file.
   - [x] Open folder in Atom.

   ## Setup

   - [x] Import `Html` package.
   - [x] Use `main` function to display `"Hello World"` text.
   - [x] Start `elm-reactor` and open browser.
   - [x] Add comments to delineate MAIN, MODEL, UPDATE, and VIEW.

   ## Model

   - [x] Create type alias for `Model` with record containing a list of strings.
   - [x] Create initial `model` with empty list `[]`.
   - [x] Add a couple of strings to the list for us to work with.
   - [x] Add type annotations.

   ## Update

   - [x] Create `Msg` type with initial `NoOp`.
   - [x] Explain `update` with `msg` and `model` parameters.
   - [x] Add type annotation for `update` function.
   - [x] Create `update` with `case` and `NoOp`.

   ## View

   - [x] Add type annotation for `view` function.
   - [x] Create `view` with initial empty `div` element.
   - [x] Inside the `div`, create `ul` and hard-code a couple of `li` elements.

   ## Html.App

   - [x] Wire everything together by importing `Html.App`.
   - [x] Update `main` with `App.beginnerProgram`.

   ## View Refactoring

   - [x] Extract hardcoded list to `list` and `listItem` functions.
   - [x] Use `List.map` to render each `listItem` in the `model`'s list.

   ## Interactivity

   - [x] Add a `button` element to toggle list.
   - [x] Import `Html.Events` and `onClick`.
   - [x] Update `Msg` and `update` with `ShowList`.
   - [x] Update `Model` and `model` with a `showList` of type `Bool`.
   - [x] Update the `ShowList` message to change the `showList` value to `True`.
   - [x] Add a conditional to our `list` function.
   - [x] If `model.showList` is `True`, then display the list.
   - [x] Otherwise, show an empty list with `ul [] []`.
   - [x] Try it out in the browser!

-}


module ListCreator exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)


-- MAIN


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = model
        , update = update
        , view = view
        }



-- MODEL


type alias Model =
    { showList : Bool
    , list : List String
    }


model : Model
model =
    { showList = False
    , list = [ "one", "two", "three" ]
    }



-- UPDATE


type Msg
    = NoOp
    | DisplayToggle


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model

        DisplayToggle ->
            { model | showList = not model.showList }



-- VIEW


view : Model -> Html Msg
view { list, showList } =
    div []
        [ button [ onClick DisplayToggle ] [ text "Display List" ]
        , if showList then
            ol
                []
                (List.map viewListItem list)
          else
            ol [] []
        ]


viewListItem : String -> Html a
viewListItem string =
    li [] [ text string ]
