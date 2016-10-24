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
    = DemoListView
    | DemoShowView DemoList.Demo


type Location
    = Home
    | Demos
    | Demo String
    | Resources
    | Presentations


init : Maybe Location -> ( Model, Cmd Msg )
init location =
    let
        route =
            routeInit location
    in
        ( { demoListModel = DemoList.initialModel
          , currentView = DemoListView
          , route = route
          }
        , Cmd.none
        )



-- UPDATE


type Msg
    = NoOp
    | UpdateView Page
    | DemoListMsg DemoList.Msg
    | DemoShowMsg DemoList.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

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
        demosModel =
            model.demoListModel

        body =
            case model.route of
                Just Home ->
                    homeView

                Just Demos ->
                    demosView model

                Just (Demo name) ->
                    demoView name demosModel.demos

                Just Resources ->
                    resourcesView

                Just Presentations ->
                    presentationsView

                Nothing ->
                    notFoundView
    in
        div [ class "elm-app" ]
            [ header model
            , body
            ]


header : Model -> Html Msg
header model =
    Html.header [ class "header" ]
        [ navigationHome
        , navigationView model
        , navigationIcons
        ]


navigationHome : Html Msg
navigationHome =
    a [ href "/" ] [ h1 [ class "header-text" ] [ text "Elm Orlando" ] ]


navigationView : Model -> Html Msg
navigationView model =
    let
        linkListItem linkData =
            li [ class "nav-list-item" ] [ navigationLink linkData ]
    in
        nav []
            [ ul [ class "nav-list" ]
                (List.map linkListItem navigationLinks)
            ]


navigationLink : ( Location, String ) -> Html Msg
navigationLink ( location, label ) =
    a [ href <| urlFor location ] [ text label ]


navigationLinks : List ( Location, String )
navigationLinks =
    [ ( Demos, "Demos" )
    , ( Resources, "Resources" )
    , ( Presentations, "Presentations" )
    ]


navigationIcons : Html Msg
navigationIcons =
    nav []
        [ ul [ class "nav nav-pills" ]
            [ li [] [ a [ href "https://www.meetup.com/ElmOrlando" ] [ img [ src "/images/meetup.png" ] [] ] ]
            , li [] [ a [ href "https://github.com/ElmOrlando" ] [ img [ src "/images/github.png" ] [] ] ]
            , li [] [ a [ href "https://twitter.com/ElmOrlandoGroup" ] [ img [ src "/images/twitter.png" ] [] ] ]
            ]
        ]


homeView : Html Msg
homeView =
    div [] []


pageView : Model -> Html Msg
pageView model =
    case model.currentView of
        DemoListView ->
            demoListView model

        DemoShowView demo ->
            demoShowView demo


demoListView : Model -> Html Msg
demoListView model =
    App.map DemoListMsg (DemoList.view model.demoListModel)


demoShowView : DemoList.Demo -> Html Msg
demoShowView demo =
    App.map DemoShowMsg (DemoList.showView demo)


demosView : Model -> Html Msg
demosView model =
    let
        demoList =
            model.demoListModel
    in
        div [ class "demos" ]
            [ h2 [] [ text "Demos" ]
            , ul [ class "demo-list" ]
                (List.map demoListItemView demoList.demos)
            ]


demoListItemView : DemoList.Demo -> Html Msg
demoListItemView demo =
    li
        [ class "demo-list-item"
          --, onClick (RouteToNewPage (ShowView demo))
        ]
        [ navigationLink ( Demo demo.name, demo.name ) ]


demoView : String -> List DemoList.Demo -> Html msg
demoView name demos =
    let
        currentDemo =
            List.filter (\d -> d.name == name) demos
                |> List.head
    in
        case currentDemo of
            Nothing ->
                text "Demo not found!"

            Just demo ->
                div []
                    [ h3 [] [ text demo.name ]
                    , ul [ class "demo-list-item" ]
                        [ li [] [ a [ href demo.liveDemoUrl ] [ text "Live Demo" ] ]
                        , li [] [ a [ href demo.sourceCodeUrl ] [ text "Source Code" ] ]
                        ]
                    ]


resourcesView : Html Msg
resourcesView =
    ResourceList.view


presentationsView : Html Msg
presentationsView =
    PresentationList.view


notFoundView : Html Msg
notFoundView =
    div [] [ p [] [ text "Page not found. Return from whence ye came." ] ]



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

                Demo name ->
                    "/demos/" ++ name

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

            [ "demos", name ] ->
                Just (Demo name)

            [ "resources" ] ->
                Just Resources

            [ "presentations" ] ->
                Just Presentations

            _ ->
                Nothing
