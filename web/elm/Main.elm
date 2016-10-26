module Main exposing (..)

import Debug
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Json.Decode as Json exposing ((:=))
import Http
import Navigation
import String
import Task


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
    { demos : List Demo
    , route : Maybe Location
    }


type alias Demo =
    { name : String
    , liveDemoUrl : String
    , sourceCodeUrl : String
    }


type Location
    = Home
    | Demos
    | DemoShow String
    | Resources
    | Presentations


init : Maybe Location -> ( Model, Cmd Msg )
init location =
    { demos = [], route = routeInit location } ! []



-- UPDATE


type Msg
    = NoOp
    | Fetch
    | FetchSucceed (List Demo)
    | FetchFail Http.Error


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        Fetch ->
            model ! [ fetchDemos ]

        FetchSucceed demoList ->
            { model | demos = demoList } ! []

        FetchFail error ->
            case error of
                Http.UnexpectedPayload errorMessage ->
                    Debug.log errorMessage model ! []

                _ ->
                    model ! []


fetchDemos : Cmd Msg
fetchDemos =
    let
        url =
            "/api/demos"
    in
        Task.perform FetchFail FetchSucceed (Http.get decodeDemoFetch url)


decodeDemoFetch : Json.Decoder (List Demo)
decodeDemoFetch =
    Json.at [ "data" ] decodeDemoList


decodeDemoList : Json.Decoder (List Demo)
decodeDemoList =
    Json.list decodeDemoData


decodeDemoData : Json.Decoder Demo
decodeDemoData =
    Json.object3 Demo
        ("name" := Json.string)
        ("liveDemoUrl" := Json.string)
        ("sourceCodeUrl" := Json.string)



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
                    demosView model

                Just (DemoShow name) ->
                    demoView name model.demos

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
    let
        demoLoader =
            if location == Demos then
                onClick Fetch
            else
                onClick NoOp
    in
        a [ demoLoader, href <| urlFor location ] [ text label ]


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


demosView : Model -> Html Msg
demosView model =
    div [ class "demos" ]
        [ h2 [] [ text "Demos" ]
        , ul [ class "demo-list" ]
            (List.map demoListItemView model.demos)
        ]


demoListItemView : Demo -> Html Msg
demoListItemView demo =
    li [ class "demo-list-item" ]
        [ navigationLink ( DemoShow demo.name, demo.name ) ]


demoView : String -> List Demo -> Html msg
demoView name demos =
    let
        currentDemo =
            List.filter (\d -> d.name == name) demos
                |> List.head
    in
        case currentDemo of
            Just demo ->
                div []
                    [ h3 [] [ text demo.name ]
                    , ul [ class "demo-list-item" ]
                        [ li [] [ a [ href demo.liveDemoUrl ] [ text "Live Demo" ] ]
                        , li [] [ a [ href demo.sourceCodeUrl ] [ text "Source Code" ] ]
                        ]
                    ]

            Nothing ->
                text "Demo not found!"


resourcesView : Html Msg
resourcesView =
    div [ class "resources" ]
        [ h2 [] [ text "Resources" ]
        , h3 [] [ text "Books" ]
        , ul []
            [ li [] [ a [ href "http://guide.elm-lang.org" ] [ text "An Introduction to Elm" ] ]
            , li [] [ a [ href "https://raorao.gitbooks.io/elmbridge-curriculum/content" ] [ text "ElmBridge Curriculum" ] ]
            ]
        , h3 [] [ text "Courses" ]
        , ul []
            [ li [] [ a [ href "http://courses.knowthen.com/courses/elm-for-beginners" ] [ text "Elm for Beginners" ] ]
            , li [] [ a [ href "https://www.dailydrip.com/topics/elm" ] [ text "DailyDrip Elm" ] ]
            ]
        , h3 [] [ text "Community" ]
        , ul []
            [ li [] [ a [ href "http://elmlang.herokuapp.com" ] [ text "Elm Slack" ] ]
            , li [] [ a [ href "https://twitter.com/elmlang" ] [ text "Elm Twitter" ] ]
            , li [] [ a [ href "http://www.elmweekly.nl" ] [ text "Elm Weekly" ] ]
            ]
        , h3 [] [ text "Elm and Phoenix" ]
        , ul []
            [ li [] [ a [ href "https://medium.com/@diamondgfx/setting-up-elm-with-phoenix-be3a9f55bac2" ] [ text "Setting Up Elm with Phoenix" ] ]
            , li [] [ a [ href "https://medium.com/@diamondgfx/writing-a-full-site-in-phoenix-and-elm-a100804c9499" ] [ text "Writing a Full Site in Phoenix and Elm" ] ]
            , li [] [ a [ href "http://www.cultivatehq.com/posts/phoenix-elm-1" ] [ text "Phoenix with Elm" ] ]
            ]
        ]


presentationsView : Html Msg
presentationsView =
    div [ class "presentations" ]
        [ h2 [] [ text "Presentations" ]
        , h3 [] [ text "September 2016" ]
        , ul []
            [ li [] [ a [ href "http://prezi.com/wofdk8e6uuy3" ] [ text "Getting to Know Elm" ] ]
            ]
        , h3 [] [ text "October 2016" ]
        , ul []
            [ li [] [ text "Elm and React (Coming Soon)" ]
            ]
        , h3 [] [ text "November 2016" ]
        , ul []
            [ li [] [ text "Solving a Problem with Elm (Coming Soon)" ]
            ]
        ]


notFoundView : Html Msg
notFoundView =
    div [] [ p [] [ text "Page not found. Return from whence ye came." ] ]



-- NAVIGATION


updateRoute : Maybe Location -> Model -> ( Model, Cmd Msg )
updateRoute route model =
    { model | route = route } ! []


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

                DemoShow name ->
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

            [ "home" ] ->
                Just Home

            [ "demos" ] ->
                Just Demos

            [ "demos", name ] ->
                Just (DemoShow name)

            [ "resources" ] ->
                Just Resources

            [ "presentations" ] ->
                Just Presentations

            _ ->
                Nothing
