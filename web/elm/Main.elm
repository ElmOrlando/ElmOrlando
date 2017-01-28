module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Json.Decode as Decode
import Http


-- MAIN


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { demos : List Demo
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


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


initialModel : Model
initialModel =
    { demos = [] }



-- UPDATE


type Msg
    = NoOp
    | FetchDemos (Result Http.Error (List Demo))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        FetchDemos (Ok newDemos) ->
            ( { model | demos = newDemos }, Cmd.none )

        FetchDemos (Err _) ->
            ( model, Cmd.none )


fetchDemos : Cmd Msg
fetchDemos =
    Http.send FetchDemos (Http.get "/api/demos" decodeDemoFetch)


decodeDemoFetch : Decode.Decoder (List Demo)
decodeDemoFetch =
    Decode.at [ "data" ] decodeDemoList


decodeDemoList : Decode.Decoder (List Demo)
decodeDemoList =
    Decode.list decodeDemoData


decodeDemoData : Decode.Decoder Demo
decodeDemoData =
    Decode.map3 Demo
        (Decode.field "name" Decode.string)
        (Decode.field "liveDemoUrl" Decode.string)
        (Decode.field "sourceCodeUrl" Decode.string)



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div [] [ header model ]


header : Model -> Html Msg
header model =
    Html.header [ class "header" ]
        [ navigationHome
        , navigationIcons
        , navigationView model
        ]


navigationHome : Html Msg
navigationHome =
    a [ href "#/" ] [ h1 [ class "header-text" ] [ text "Elm Orlando" ] ]


navigationView : Model -> Html Msg
navigationView model =
    nav []
        [ ul [ class "nav-list" ]
            [ li [] [ text "Demos" ]
            , li [] [ text "Resources" ]
            , li [] [ text "Presentations" ]
            ]
        ]


navigationIcons : Html Msg
navigationIcons =
    nav []
        [ ul [ class "nav nav-pills" ]
            [ navigationIconItem "https://www.meetup.com/ElmOrlando" "/images/meetup.png"
            , navigationIconItem "https://github.com/ElmOrlando" "/images/github.png"
            , navigationIconItem "https://twitter.com/ElmOrlandoGroup" "/images/twitter.png"
            ]
        ]


navigationIconItem : String -> String -> Html Msg
navigationIconItem url imgSrc =
    li [] [ a [ href url ] [ img [ src imgSrc ] [] ] ]


homeView : Html Msg
homeView =
    div [] []


demosView : Model -> Html Msg
demosView model =
    div [ class "demos" ]
        [ h2 [] [ text "Demos" ]
        , ul [ class "demo-list" ] []
        ]


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
            [ resourceView "http://guide.elm-lang.org" "An Introduction to Elm"
            , resourceView "http://elmprogramming.com/" "Beginning Elm"
            , resourceView "https://raorao.gitbooks.io/elmbridge-curriculum/content" "ElmBridge Curriculum"
            ]
        , h3 [] [ text "Courses" ]
        , ul []
            [ resourceView "http://courses.knowthen.com/courses/elm-for-beginners" "Elm for Beginners"
            , resourceView "https://www.dailydrip.com/topics/elm" "DailyDrip Elm"
            ]
        , h3 [] [ text "Community" ]
        , ul []
            [ resourceView "http://elmlang.herokuapp.com" "Elm Slack"
            , resourceView "https://twitter.com/elmlang" "Elm Twitter"
            , resourceView "http://www.elmweekly.nl" "Elm Weekly"
            ]
        , h3 [] [ text "Elm and Phoenix" ]
        , ul []
            [ resourceView "https://medium.com/@diamondgfx/setting-up-elm-with-phoenix-be3a9f55bac2" "Setting Up Elm with Phoenix"
            , resourceView "https://medium.com/@diamondgfx/writing-a-full-site-in-phoenix-and-elm-a100804c9499" "Writing a Full Site in Phoenix and Elm"
            , resourceView "http://www.cultivatehq.com/posts/phoenix-elm-1" "Phoenix with Elm"
            ]
        ]


resourceView : String -> String -> Html Msg
resourceView url title =
    li [] [ a [ href url ] [ text title ] ]


presentationsView : Html Msg
presentationsView =
    div [ class "presentations" ]
        [ h2 [] [ text "Presentations" ]
        , h3 [] [ text "September 2016" ]
        , ul [] [ li [] [ a [ href "http://prezi.com/wofdk8e6uuy3" ] [ text "Getting to Know Elm" ] ] ]
        , h3 [] [ text "October 2016" ]
        , ul [] [ li [] [ text "Elm and React" ] ]
        , h3 [] [ text "November 2016" ]
        , ul [] [ li [] [ a [ href "https://prezi.com/f0lpwk_xlj4p" ] [ text "Solving a Problem with Elm" ] ] ]
        , h3 [] [ text "December 2016" ]
        , ul [] [ li [] [ a [ href "https://cl.ly/0U2n0R3J3A2t/download/input_and_subscriptions.pdf" ] [ text "Input and Subscriptions" ] ] ]
        ]


notFoundView : Html Msg
notFoundView =
    div [] [ p [] [ text "Page not found. Return from whence ye came." ] ]
