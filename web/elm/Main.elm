module Main exposing (..)

import Html.App as App
import Html exposing (..)
import Html.Attributes exposing (..)
import Components.DemoList as DemoList


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
    { demoListModel : DemoList.Model }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


initialModel : Model
initialModel =
    { demoListModel = DemoList.initialModel }



-- UPDATE


type Msg
    = DemoListMsg DemoList.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DemoListMsg demoMsg ->
            let
                ( updatedModel, cmd ) =
                    DemoList.update demoMsg model.demoListModel
            in
                ( { model | demoListModel = updatedModel }, Cmd.map DemoListMsg cmd )



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "elm-app" ]
        [ App.map DemoListMsg (DemoList.view model.demoListModel) ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
