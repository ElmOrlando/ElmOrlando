module Components.DemoList exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import List
import Components.Demo as Demo
import Http
import Task
import Json.Decode as Json exposing ((:=))
import Debug


-- MODEL


type alias Model =
    { demos : List Demo.Model }


type SubPage
    = ListView
    | ShowView Demo.Model


initialModel : Model
initialModel =
    { demos = [] }



-- UPDATE


type Msg
    = NoOp
    | Fetch
    | FetchSucceed (List Demo.Model)
    | FetchFail Http.Error
    | RouteToNewPage SubPage


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        Fetch ->
            ( model, fetchDemos )

        FetchSucceed demoList ->
            ( Model demoList, Cmd.none )

        FetchFail error ->
            case error of
                Http.UnexpectedPayload errorMessage ->
                    Debug.log errorMessage
                        ( model, Cmd.none )

                _ ->
                    ( model, Cmd.none )

        _ ->
            ( model, Cmd.none )


fetchDemos : Cmd Msg
fetchDemos =
    let
        url =
            "/api/demos"
    in
        Task.perform FetchFail FetchSucceed (Http.get decodeDemoFetch url)


decodeDemoFetch : Json.Decoder (List Demo.Model)
decodeDemoFetch =
    Json.at [ "data" ] decodeDemoList


decodeDemoList : Json.Decoder (List Demo.Model)
decodeDemoList =
    Json.list decodeDemoData


decodeDemoData : Json.Decoder Demo.Model
decodeDemoData =
    Json.object3 Demo.Model
        ("name" := Json.string)
        ("liveDemoUrl" := Json.string)
        ("sourceCodeUrl" := Json.string)



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "demo-list" ]
        [ h2 [] [ text "Demos" ]
        , ul [] (renderDemos model)
        ]


renderDemos : Model -> List (Html Msg)
renderDemos model =
    List.map renderDemo model.demos


renderDemo : Demo.Model -> Html Msg
renderDemo demo =
    li [ class "demo-list-item" ]
        [ a
            [ href ("#demo/" ++ demo.name ++ "/show")
            , onClick (RouteToNewPage (ShowView demo))
            ]
            [ text demo.name ]
        ]
