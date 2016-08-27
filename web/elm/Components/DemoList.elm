module Components.DemoList exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import List
import Demo
import Http
import Task
import Json.Decode as Json exposing ((:=))
import Debug


-- MODEL


type alias Model =
    { demos : List Demo.Model }


demos : Model
demos =
    { demos =
        [ { name = "Hello World", liveDemoUrl = "#", sourceCodeUrl = "#" }
        , { name = "Counter", liveDemoUrl = "#", sourceCodeUrl = "#" }
        , { name = "Mario", liveDemoUrl = "#", sourceCodeUrl = "#" }
        ]
    }


initialModel : Model
initialModel =
    { demos = [] }



-- UPDATE


type Msg
    = NoOp
    | Fetch
    | FetchSucceed (List Demo.Model)
    | FetchFail Http.Error


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        -- TODO: Implement when Phoenix Demo API is ready.
        -- ( model, fetchDemos )
        Fetch ->
            ( demos, Cmd.none )

        FetchSucceed demoList ->
            ( Model demoList, Cmd.none )

        FetchFail error ->
            case error of
                Http.UnexpectedPayload errorMessage ->
                    Debug.log errorMessage
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
          -- TODO: Remove button when Phoenix Demo API is ready.
        , button [ onClick Fetch, class "btn btn-primary" ] [ text "Fetch Demos" ]
        , ul [] (renderDemos model)
        ]


renderDemos : Model -> List (Html a)
renderDemos model =
    List.map renderDemo model.demos


renderDemo : Demo.Model -> Html a
renderDemo demo =
    li [] [ Demo.view demo ]
