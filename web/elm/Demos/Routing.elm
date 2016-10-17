module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Navigation
import String exposing (split)


-- MAIN


main : Program Never
main =
    Navigation.program (Navigation.makeParser locFor)
        { init = init
        , update = update
        , urlUpdate = updateRoute
        , view = view
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { route : Maybe Location
    }


type Location
    = Home
    | Topics


init : Maybe Location -> ( Model, Cmd Msg )
init location =
    let
        route =
            routeInit location
    in
        { route = route
        }
            ! []



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    let
        body =
            case model.route of
                Just Home ->
                    homeView

                Just Topics ->
                    topicsView

                Nothing ->
                    notFoundView
    in
        div []
            [ navigationView model
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
navigationLink ( loc, label ) =
    a [ href <| urlFor loc ] [ text label ]


navigationLinks : List ( Location, String )
navigationLinks =
    [ ( Home, "Home" )
    , ( Topics, "Topics" )
    ]


homeView : Html msg
homeView =
    text "This is the Home page."


topicsView : Html msg
topicsView =
    text "This is the Topics page."


notFoundView : Html msg
notFoundView =
    text "Page not found."



-- ROUTING


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

                Topics ->
                    "/topics"
    in
        "#" ++ url


locFor : Navigation.Location -> Maybe Location
locFor path =
    let
        segments =
            path.hash
                |> split "/"
                |> List.filter (\seg -> seg /= "" && seg /= "#")
    in
        case segments of
            -- No segments means we're on the home page
            [] ->
                Just Home

            -- "/topics" means we're on the topics page
            [ "topics" ] ->
                Just Topics

            -- Otherwise, return `Nothing` and let our "not found" view take over
            _ ->
                Nothing
