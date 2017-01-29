module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
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
    { currentPage : Page
    , demos : List Demo
    , resources : List Resource
    , presentations : List Presentation
    }


type Page
    = Home
    | Demos
    | Resources
    | Presentations


type alias Demo =
    { name : String
    , category : String
    , liveDemoUrl : String
    , sourceCodeUrl : String
    }


type alias Resource =
    { name : String
    , category : String
    , url : String
    }


type alias Presentation =
    { name : String
    , category : String
    , author : String
    , url : String
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


initialModel : Model
initialModel =
    { currentPage = Home
    , demos = []
    , resources = []
    , presentations = []
    }



-- TEMP DATA


tempResourcesData : List Resource
tempResourcesData =
    [ { name = "An Introduction to Elm", category = "book", url = "http://guide.elm-lang.org" }
    , { name = "Beginning Elm", category = "book", url = "http://elmprogramming.com" }
    , { name = "ElmBridge Curriculum", category = "book", url = "https://raorao.gitbooks.io/elmbridge-curriculum/content" }
    , { name = "Elm for Beginners", category = "course", url = "http://courses.knowthen.com/courses/elm-for-beginners" }
    , { name = "DailyDrip Elm", category = "course", url = "https://www.dailydrip.com/topics/elm" }
    , { name = "Elm Slack", category = "community", url = "http://elmlang.herokuapp.com" }
    , { name = "Elm Twitter", category = "community", url = "https://twitter.com/elmlang" }
    , { name = "Elm Weekly", category = "community", url = "http://www.elmweekly.nl" }
    ]



-- UPDATE


type Msg
    = NoOp
    | UpdateView Page
    | FetchDemos (Result Http.Error (List Demo))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        UpdateView page ->
            case page of
                _ ->
                    ( { model | currentPage = page }, Cmd.none )

        FetchDemos (Ok newDemos) ->
            ( { model | demos = newDemos }, Cmd.none )

        FetchDemos (Err _) ->
            ( model, Cmd.none )



-- ROUTING


pageView : Model -> Html Msg
pageView model =
    case model.currentPage of
        Home ->
            homeView

        Demos ->
            demosView model

        Resources ->
            resourcesView

        Presentations ->
            presentationsView



-- API


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
    Decode.map4 Demo
        (Decode.field "name" Decode.string)
        (Decode.field "category" Decode.string)
        (Decode.field "liveDemoUrl" Decode.string)
        (Decode.field "sourceCodeUrl" Decode.string)



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ header model
        , pageView model
        ]


header : Model -> Html Msg
header model =
    Html.header [ class "header" ]
        [ home
        , externalLinksList
        , internalLinksList model
        ]


home : Html Msg
home =
    a [ href "#home", onClick <| UpdateView Home ] [ h1 [ class "header-text" ] [ text "Elm Orlando" ] ]


externalLinksList : Html Msg
externalLinksList =
    nav [] [ ul [ class "nav nav-pills" ] externalLinks ]


externalLinks : List (Html Msg)
externalLinks =
    [ li [] [ a [ href "https://www.meetup.com/ElmOrlando" ] [ img [ src "/images/meetup.png" ] [] ] ]
    , li [] [ a [ href "https://github.com/ElmOrlando" ] [ img [ src "/images/github.png" ] [] ] ]
    , li [] [ a [ href "https://twitter.com/ElmOrlandoGroup" ] [ img [ src "/images/twitter.png" ] [] ] ]
    ]


internalLinksList : Model -> Html Msg
internalLinksList model =
    nav [] [ ul [ class "nav-list" ] internalLinks ]


internalLinks : List (Html Msg)
internalLinks =
    [ li [] [ a [ href "#demos", onClick <| UpdateView Demos ] [ text "Demos" ] ]
    , li [] [ a [ href "#resources", onClick <| UpdateView Resources ] [ text "Resources" ] ]
    , li [] [ a [ href "#presentations", onClick <| UpdateView Presentations ] [ text "Presentations" ] ]
    ]


homeView : Html Msg
homeView =
    div [] []


demosView : Model -> Html Msg
demosView model =
    div [ class "demos" ]
        [ h2 [] [ text "Demos" ]
        , ul [ class "demo-list" ] (List.map demoView model.demos)
        ]


demoView : Demo -> Html Msg
demoView demo =
    li [ class "demo-list-item" ]
        [ p [] [ a [ href demo.name ] [ text demo.name ] ]
        , p [] [ a [ href demo.category ] [ text demo.category ] ]
        , p [] [ a [ href demo.liveDemoUrl ] [ text "Live" ] ]
        , p [] [ a [ href demo.sourceCodeUrl ] [ text "Source" ] ]
        ]


resourcesView : Html Msg
resourcesView =
    div [ class "resources" ]
        [ h2 [] [ text "Resources" ]
        , h3 [] [ text "Books" ]
        , ul [] (List.map resourceView (resourceBooks tempResourcesData))
        , h3 [] [ text "Courses" ]
        , ul [] (List.map resourceView (resourceCourses tempResourcesData))
        , h3 [] [ text "Community" ]
        , ul [] (List.map resourceView (resourceCommunity tempResourcesData))
        ]


resourceView : Resource -> Html Msg
resourceView resource =
    li [] [ a [ href resource.url ] [ text resource.name ] ]


resourceBooks : List Resource -> List Resource
resourceBooks resources =
    List.filter resourceIsBook resources


resourceIsBook : Resource -> Bool
resourceIsBook resource =
    resource.category == "book"


resourceCourses : List Resource -> List Resource
resourceCourses resources =
    List.filter resourceIsCourse resources


resourceIsCourse : Resource -> Bool
resourceIsCourse resource =
    resource.category == "course"


resourceCommunity : List Resource -> List Resource
resourceCommunity resources =
    List.filter resourceIsCommunity resources


resourceIsCommunity : Resource -> Bool
resourceIsCommunity resource =
    resource.category == "community"


tempPresentationsData : List Presentation
tempPresentationsData =
    [ { name = "Getting to Know Elm", category = "September 2016", author = "Bijan Boustani", url = "http://prezi.com/wofdk8e6uuy3" }
    , { name = "React and Elm", category = "October 2016", author = "David Khourshid", url = "" }
    , { name = "Solving a Problem with Elm", category = "November 2016", author = "Bijan Boustani", url = "https://prezi.com/f0lpwk_xlj4p" }
    , { name = "Input and Subscriptions", category = "December 2016", author = "AJ Foster", url = "https://d17oy1vhnax1f7.cloudfront.net/items/3X3A1q0u372R1g39083G/input_and_subscriptions.pdf" }
    , { name = "Functional Concepts", category = "January 2017", author = "Devan Kestel", url = "" }
    , { name = "Elixir and Elm", category = "January 2017", author = "Bijan Boustani", url = "" }
    ]


presentationsView : Html Msg
presentationsView =
    div [ class "presentations" ]
        [ h2 [] [ text "Presentations" ]
        , ul [] (List.map presentationView tempPresentationsData)
        ]


presentationView : Presentation -> Html Msg
presentationView presentation =
    li []
        [ a [ href presentation.url ] [ text presentation.name ]
        , span [] [ text presentation.author ]
        ]
