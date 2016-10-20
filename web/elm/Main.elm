module Main exposing (..)

import Html.App as App
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Components.DemoList as DemoList
import Components.ResourceList as ResourceList
import Components.PresentationList as PresentationList


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
    | DemoShowView DemoList.Demo
    | ResourceListView
    | PresentationListView


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
    = UpdateView Page
    | DemoListMsg DemoList.Msg
    | DemoShowMsg DemoList.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DemoListMsg demoMsg ->
            case demoMsg of
                DemoList.RouteToNewPage page ->
                    case page of
                        DemoList.ShowView demo ->
                            ( { model | currentView = (DemoShowView demo) }, Cmd.none )

                        _ ->
                            ( model, Cmd.none )

                _ ->
                    let
                        ( updatedModel, cmd ) =
                            DemoList.update demoMsg model.demoListModel
                    in
                        ( { model | demoListModel = updatedModel }, Cmd.map DemoListMsg cmd )

        UpdateView page ->
            case page of
                DemoListView ->
                    ( { model | currentView = page }, Cmd.map DemoListMsg DemoList.fetchDemos )

                _ ->
                    ( { model | currentView = page }, Cmd.none )

        DemoShowMsg demoMsg ->
            ( model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "elm-app" ]
        [ header, pageView model ]


pageView : Model -> Html Msg
pageView model =
    case model.currentView of
        RootView ->
            welcomeView

        DemoListView ->
            demoListView model

        DemoShowView demo ->
            demoShowView demo

        ResourceListView ->
            resourceListView

        PresentationListView ->
            presentationListView


header : Html Msg
header =
    Html.header [ class "header" ]
        [ a [ href "#", onClick (UpdateView RootView) ] [ h1 [ class "header-text" ] [ text "Elm Orlando" ] ]
        , nav []
            [ ul [ class "nav nav-pills" ]
                [ li [] [ a [ href "https://www.meetup.com/ElmOrlando" ] [ img [ src "/images/meetup.png" ] [] ] ]
                , li [] [ a [ href "https://github.com/ElmOrlando" ] [ img [ src "/images/github.png" ] [] ] ]
                , li [] [ a [ href "https://twitter.com/ElmOrlandoGroup" ] [ img [ src "/images/twitter.png" ] [] ] ]
                ]
            ]
        ]


welcomeView : Html Msg
welcomeView =
    div []
        [ h2 [ class "page-link" ] [ a [ href "#demos", onClick (UpdateView DemoListView) ] [ text "Demos" ] ]
        , h2 [ class "page-link" ] [ a [ href "#resources", onClick (UpdateView ResourceListView) ] [ text "Resources" ] ]
        , h2 [ class "page-link" ] [ a [ href "#presentations", onClick (UpdateView PresentationListView) ] [ text "Presentations" ] ]
        ]


demoListView : Model -> Html Msg
demoListView model =
    App.map DemoListMsg (DemoList.view model.demoListModel)


demoShowView : DemoList.Demo -> Html Msg
demoShowView demo =
    App.map DemoShowMsg (DemoList.showView demo)


resourceListView : Html a
resourceListView =
    ResourceList.view


presentationListView : Html a
presentationListView =
    PresentationList.view
