{-
   **Routing Demo**

   Simple example of routing from one location to another in a Single Page
   Application. Definitely sign up at DailyDrip.com for an in-depth lesson about
   how to do this!
-}


module Routing exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Http
import Navigation
import UrlParser exposing ((</>), (<?>))


-- MAIN


main : Program Never Model Msg
main =
    Navigation.program UrlChange
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { history : List (Maybe Route)
    , games : List (Maybe Game)
    }


type alias Game =
    { id : Int
    , title : String
    , slug : String
    }


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    ( { history = [ UrlParser.parsePath route location ]
      , games = []
      }
    , Cmd.none
    )



-- URL PARSING


type Route
    = HomeRoute
    | GameListRoute (Maybe String)
    | GameRoute String


route : UrlParser.Parser (Route -> a) a
route =
    UrlParser.oneOf
        [ UrlParser.map HomeRoute UrlParser.top
        , UrlParser.map GameListRoute (UrlParser.s "games" <?> UrlParser.stringParam "search")
        , UrlParser.map GameRoute (UrlParser.s "games" </> UrlParser.string)
        ]



-- UPDATE


type Msg
    = NewUrl String
    | UrlChange Navigation.Location


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewUrl url ->
            ( model, Navigation.newUrl url )

        UrlChange location ->
            ( { model | history = UrlParser.parsePath route location :: model.history }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Links" ]
        , ul [] (List.map viewLink exampleLinks)
        , h1 [] [ text "History" ]
        , ul [] (List.map viewRoute model.history)
        ]


exampleLinks : List String
exampleLinks =
    [ "/"
    , "/games/"
    , "/games/mario"
    , "/games/zelda"
    , "/games/contra"
    , "/games/?search=mario"
    ]


viewLink : String -> Html Msg
viewLink url =
    li [] [ button [ onClick (NewUrl url) ] [ text url ] ]


viewRoute : Maybe Route -> Html msg
viewRoute maybeRoute =
    case maybeRoute of
        Nothing ->
            li [] [ text "Invalid URL" ]

        Just route ->
            li [] [ code [] [ text (routeToString route) ] ]


routeToString : Route -> String
routeToString route =
    case route of
        HomeRoute ->
            "Home"

        GameListRoute Nothing ->
            "All Games"

        GameListRoute (Just search) ->
            "Search for " ++ Http.encodeUri search

        GameRoute slug ->
            "Show Game " ++ slug
