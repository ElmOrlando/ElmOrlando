module Main exposing (..)

import Html.App as App
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
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
    { demoListModel : DemoList.Model
    , currentView : Page
    }


type Page
    = RootView
    | DemoListView


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


initialModel : Model
initialModel =
    { demoListModel = DemoList.initialModel
    , currentView = RootView
    }



-- UPDATE


type Msg
    = DemoListMsg DemoList.Msg
    | UpdateView Page


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DemoListMsg demoMsg ->
            let
                ( updatedModel, cmd ) =
                    DemoList.update demoMsg model.demoListModel
            in
                ( { model | demoListModel = updatedModel }, Cmd.map DemoListMsg cmd )

        UpdateView page ->
            ( { model | currentView = page }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "elm-app" ]
        [ header, pageView model ]


header : Html Msg
header =
    div []
        [ h1 [] [ text "Elm Orlando" ]
        , ul []
            [ li [] [ a [ href "#", onClick (UpdateView RootView) ] [ text "Home" ] ]
            , li [] [ a [ href "#demos", onClick (UpdateView DemoListView) ] [ text "Demos" ] ]
            ]
        ]


pageView : Model -> Html Msg
pageView model =
    case model.currentView of
        RootView ->
            welcomeView

        DemoListView ->
            demoListView model


welcomeView : Html Msg
welcomeView =
    h2 [] [ text "Home" ]


demoListView : Model -> Html Msg
demoListView model =
    App.map DemoListMsg (DemoList.view model.demoListModel)



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
