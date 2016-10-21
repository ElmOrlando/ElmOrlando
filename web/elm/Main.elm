module Main exposing (..)

import Html.App as App
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Components.DemoList as DemoList
import Components.ResourceList as ResourceList
import Components.PresentationList as PresentationList
import Navigation
import String


-- MAIN


main : Program Never
main =
    Navigation.program (Navigation.makeParser locationFor)
        { init = init
        , update = update
        , urlUpdate = updateRoute
        , view = view
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { demoListModel : DemoList.Model
    , currentView : Page
    , route : Maybe Location
    }


type Page
    = RootView
    | DemoListView
    | DemoShowView DemoList.Demo
    | ResourceListView
    | PresentationListView


type Location
    = Home
    | Demos
    | Resources
    | Presentations


init : Maybe Location -> ( Model, Cmd Msg )
init location =
    let
        route =
            routeInit location
    in
        ( { demoListModel = DemoList.initialModel
          , currentView = RootView
          , route = route
          }
        , Cmd.none
        )



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
    let
        body =
            case model.route of
                Just Home ->
                    homeView

                Just Demos ->
                    demosView

                Just Resources ->
                    resourcesView

                Just Presentations ->
                    presentationsView

                Nothing ->
                    notFoundView
    in
        div [ class "elm-app" ]
            [ header
            , navigationView model
            , body
            ]


navigationView : Model -> Html Msg
navigationView model =
    let
        linkListItem linkData =
            li [] [ navigationLink linkData ]
    in
        nav []
            [ ul []
                (List.map linkListItem navigationLinks)
            ]


navigationLink : ( Location, String ) -> Html Msg
navigationLink ( location, label ) =
    a [ href <| urlFor location ] [ text label ]


navigationLinks : List ( Location, String )
navigationLinks =
    [ ( Home, "Home" )
    , ( Demos, "Demos" )
    , ( Resources, "Resources" )
    , ( Presentations, "Presentations" )
    ]


homeView : Html msg
homeView =
    text "This is the Home page."


demosView : Html msg
demosView =
    text "This is the Demos page."


resourcesView : Html msg
resourcesView =
    text "This is the Resources page."


presentationsView : Html msg
presentationsView =
    text "This is the Presentations page."


notFoundView : Html msg
notFoundView =
    text "Page not found."


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



-- NAVIGATION


updateRoute : Maybe Location -> Model -> ( Model, Cmd Msg )
updateRoute route model =
    ( { model | route = route }, Cmd.none )


routeInit : Maybe Location -> Maybe Location
routeInit location =
    location


urlFor : Location -> String
urlFor loc =
    let
        url =
            case loc of
                Home ->
                    "/"

                Demos ->
                    "/demos"

                Resources ->
                    "/resources"

                Presentations ->
                    "/presentations"
    in
        "#" ++ url


locationFor : Navigation.Location -> Maybe Location
locationFor path =
    let
        segments =
            path.hash
                |> String.split "/"
                |> List.filter (\seg -> seg /= "" && seg /= "#")
    in
        case segments of
            [] ->
                Just Home

            [ "demos" ] ->
                Just Demos

            [ "resources" ] ->
                Just Resources

            [ "presentations" ] ->
                Just Presentations

            _ ->
                Nothing
