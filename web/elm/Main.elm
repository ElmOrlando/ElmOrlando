module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Http
import Json.Decode as Decode
import Navigation


-- MAIN


main : Program Never Model Msg
main =
    Navigation.program locationToMessage
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



-- TYPES


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
    | NotFound


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



-- INIT


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    ( location
        |> initPage
        |> initialModel
    , fetchAll
    )


initialModel : Page -> Model
initialModel page =
    { currentPage = page
    , demos = []
    , resources = []
    , presentations = []
    }



-- UPDATE


type Msg
    = NoOp
    | Navigate Page
    | ChangePage Page
    | FetchDemos (Result Http.Error (List Demo))
    | FetchResources (Result Http.Error (List Resource))
    | FetchPresentations (Result Http.Error (List Presentation))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        Navigate page ->
            ( { model | currentPage = page }, pageToHash page |> Navigation.newUrl )

        ChangePage page ->
            ( { model | currentPage = page }, Cmd.none )

        FetchDemos (Ok newDemos) ->
            ( { model | demos = newDemos }, Cmd.none )

        FetchDemos (Err _) ->
            ( model, Cmd.none )

        FetchResources (Ok newResources) ->
            ( { model | resources = newResources }, Cmd.none )

        FetchResources (Err _) ->
            ( model, Cmd.none )

        FetchPresentations (Ok newPresentations) ->
            ( { model | presentations = newPresentations }, Cmd.none )

        FetchPresentations (Err _) ->
            ( model, Cmd.none )



-- ROUTING


locationToMessage : Navigation.Location -> Msg
locationToMessage location =
    location.hash
        |> hashToPage
        |> ChangePage


initPage : Navigation.Location -> Page
initPage location =
    hashToPage location.hash


hashToPage : String -> Page
hashToPage hash =
    case hash of
        "#/" ->
            Home

        "#/demos" ->
            Demos

        "#/resources" ->
            Resources

        "#/presentations" ->
            Presentations

        _ ->
            NotFound


pageToHash : Page -> String
pageToHash page =
    case page of
        Home ->
            "#/"

        Demos ->
            "#/demos"

        Resources ->
            "#/resources"

        Presentations ->
            "#/presentations"

        NotFound ->
            "#/notfound"


pageView : Model -> Html Msg
pageView model =
    case model.currentPage of
        Home ->
            viewHome

        Demos ->
            viewDemos model

        Resources ->
            viewResources model

        Presentations ->
            viewPresentations model

        _ ->
            viewHome



-- API


fetchAll : Cmd Msg
fetchAll =
    Cmd.batch [ fetchDemos, fetchResources, fetchPresentations ]


fetchDemos : Cmd Msg
fetchDemos =
    decodeDemoFetch
        |> Http.get "/api/demos"
        |> Http.send FetchDemos


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


fetchResources : Cmd Msg
fetchResources =
    decodeResourceFetch
        |> Http.get "/api/resources"
        |> Http.send FetchResources


decodeResourceFetch : Decode.Decoder (List Resource)
decodeResourceFetch =
    Decode.at [ "data" ] decodeResourceList


decodeResourceList : Decode.Decoder (List Resource)
decodeResourceList =
    Decode.list decodeResourceData


decodeResourceData : Decode.Decoder Resource
decodeResourceData =
    Decode.map3 Resource
        (Decode.field "name" Decode.string)
        (Decode.field "category" Decode.string)
        (Decode.field "url" Decode.string)


fetchPresentations : Cmd Msg
fetchPresentations =
    decodePresentationFetch
        |> Http.get "/api/presentations"
        |> Http.send FetchPresentations


decodePresentationFetch : Decode.Decoder (List Presentation)
decodePresentationFetch =
    Decode.at [ "data" ] decodePresentationList


decodePresentationList : Decode.Decoder (List Presentation)
decodePresentationList =
    Decode.list decodePresentationData


decodePresentationData : Decode.Decoder Presentation
decodePresentationData =
    Decode.map4 Presentation
        (Decode.field "name" Decode.string)
        (Decode.field "category" Decode.string)
        (Decode.field "author" Decode.string)
        (Decode.field "url" Decode.string)



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ viewHeader
        , viewPage model
        ]


viewHeader : Html Msg
viewHeader =
    Html.header [ class "header" ]
        [ homeLink
        , externalLinksList
        , internalLinksList
        ]


viewPage : Model -> Html Msg
viewPage model =
    case model.currentPage of
        Home ->
            viewHome

        Demos ->
            viewDemos model

        Resources ->
            viewResources model

        Presentations ->
            viewPresentations model

        _ ->
            viewHome


homeLink : Html Msg
homeLink =
    a [ onClick <| Navigate Home ] [ h1 [ class "header-text" ] [ text "Elm Orlando" ] ]


externalLinksList : Html Msg
externalLinksList =
    nav [] [ ul [ class "nav nav-pills" ] externalLinks ]


externalLinks : List (Html Msg)
externalLinks =
    [ li [] [ a [ href "https://www.meetup.com/ElmOrlando" ] [ img [ src "/images/meetup.png" ] [] ] ]
    , li [] [ a [ href "https://github.com/ElmOrlando" ] [ img [ src "/images/github.png" ] [] ] ]
    , li [] [ a [ href "https://twitter.com/ElmOrlandoGroup" ] [ img [ src "/images/twitter.png" ] [] ] ]
    ]


internalLinksList : Html Msg
internalLinksList =
    nav [] [ ul [ class "nav-list" ] internalLinks ]


internalLinks : List (Html Msg)
internalLinks =
    [ li [] [ a [ onClick <| Navigate Demos, pointerHoverStyle ] [ text "Demos" ] ]
    , li [] [ a [ onClick <| Navigate Resources, pointerHoverStyle ] [ text "Resources" ] ]
    , li [] [ a [ onClick <| Navigate Presentations, pointerHoverStyle ] [ text "Presentations" ] ]
    ]


viewHome : Html Msg
viewHome =
    div [] []


viewDemos : Model -> Html Msg
viewDemos { demos } =
    div []
        [ h2 [] [ text "Demos" ]
        , h3 [] [ text "Live Collaborative Coding" ]
        , ul [ class "demo-list" ] (demos |> collaborativeDemos |> List.map viewDemo)
        , h3 [] [ text "Example Demos" ]
        , ul [ class "demo-list" ] (demos |> exampleDemos |> List.map viewDemo)
        ]


viewDemo : Demo -> Html Msg
viewDemo demo =
    li [ class "demo-list-item" ]
        [ span [ class "demo-live-url" ] [ a [ href demo.liveDemoUrl ] [ text demo.name ] ]
        , span [] [ text " –" ]
        , span [ class "demo-source-code" ] [ a [ href demo.sourceCodeUrl ] [ text "Source Code" ] ]
        ]


collaborativeDemos : List Demo -> List Demo
collaborativeDemos demos =
    List.filter demoIsCollaborative demos


demoIsCollaborative : Demo -> Bool
demoIsCollaborative demo =
    demo.category == "live"


exampleDemos : List Demo -> List Demo
exampleDemos demos =
    List.filter demoIsExample demos


demoIsExample : Demo -> Bool
demoIsExample demo =
    demo.category == "example"


viewResources : Model -> Html Msg
viewResources { resources } =
    div [ class "resources" ]
        [ h2 [] [ text "Resources" ]
        , h3 [] [ text "Books" ]
        , ul [] (resources |> resourceBooks |> List.map viewResource)
        , h3 [] [ text "Courses" ]
        , ul [] (resources |> resourceCourses |> List.map viewResource)
        , h3 [] [ text "Community" ]
        , ul [] (resources |> resourceCommunity |> List.map viewResource)
        ]


viewResource : Resource -> Html Msg
viewResource resource =
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


viewPresentations : Model -> Html Msg
viewPresentations { presentations } =
    div [ class "presentations" ]
        [ h2 [] [ text "Presentations" ]
        , ul [] (presentations |> List.map viewPresentation)
        ]


viewPresentation : Presentation -> Html Msg
viewPresentation presentation =
    let
        presentationLink =
            case presentation.url of
                "" ->
                    span [] [ text presentation.name ]

                _ ->
                    a [ href presentation.url ] [ text presentation.name ]
    in
        li []
            [ p [] [ text presentation.category ]
            , p [] [ presentationLink, span [ class "presentation-author" ] [ text presentation.author ] ]
            ]



-- STYLES


pointerHoverStyle : Attribute msg
pointerHoverStyle =
    style
        [ ( "cursor", "pointer" ) ]
