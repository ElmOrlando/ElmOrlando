{-
   **Chat Demo**

   Example of using Websockets to create a small chat application.
-}


module Chat exposing (..)

import Html.App as App
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import WebSocket


-- MAIN


main : Program Never
main =
    App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { input : String
    , messages : List String
    }


init : ( Model, Cmd Msg )
init =
    ( { input = ""
      , messages = []
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = Input String
    | Send
    | NewMessage String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg { input, messages } =
    case msg of
        Input newInput ->
            ( Model newInput messages, Cmd.none )

        Send ->
            ( Model "" messages, WebSocket.send "ws:echo.websocket.org" input )

        NewMessage str ->
            ( Model input (str :: messages), Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    WebSocket.listen "ws:echo.websocket.org" NewMessage



-- VIEW


view : Model -> Html Msg
view model =
    div
        [ class "chat"
        , style
            [ ( "font-family", "Helvetica" )
            , ( "font-size", "40px" )
            , ( "margin-left", "40px" )
            ]
        ]
        [ h1 [] [ text "Chat" ]
        , input [ onInput Input ] []
        , button [ onClick Send ] [ text "Send" ]
        , div [] (List.map viewMessage model.messages)
        ]


viewMessage : String -> Html msg
viewMessage msg =
    div [] [ text msg ]
