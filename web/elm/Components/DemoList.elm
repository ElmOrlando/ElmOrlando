module Components.DemoList exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import List
import Demo


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


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        Fetch ->
            ( demos, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "demo-list" ]
        [ h2 [] [ text "Demos" ]
        , button [ onClick Fetch, class "btn btn-primary" ] [ text "Fetch Demos" ]
        , ul [] (renderDemos model)
        ]


renderDemos : Model -> List (Html a)
renderDemos model =
    List.map renderDemo model.demos


renderDemo : Demo.Model -> Html a
renderDemo demo =
    li [] [ Demo.view demo ]
