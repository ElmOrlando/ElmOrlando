{-
   **Chat Demo**

    Elm and Phoenix example application using the RemoteData library to poll
    for messages. Messages are persisted to the database via the Message model
    in Phoenix. If you'd like to learn more, this example is adapted from this
    great article about Elm:

    https://bendyworks.com/blog/elm-frontend-right-now-updated-for-0-18
-}


module Chat exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onSubmit, onInput)
import Http
import Json.Decode as Decode
import Json.Encode as Encode
import RemoteData
import Task
import Time


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
    { messages : ChatList
    , saying : Saying
    , name : Name
    }


type alias ChatList =
    RemoteData.WebData (List ChatMessage)


type alias Name =
    String


type alias Saying =
    String


type alias ChatMessage =
    { name : Name
    , message : Saying
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, prefetchMessages )


initialModel : Model
initialModel =
    { messages = RemoteData.NotAsked
    , saying = ""
    , name = ""
    }



-- UPDATE


type Msg
    = NoOp
    | SendMessage Name Saying
    | Incoming ChatList
    | Input String
    | SetName String
    | PollMessages


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        SendMessage name saying ->
            let
                message =
                    ChatMessage name saying
            in
                ( { model | saying = "" }, sendMessage message (always PollMessages) )

        Incoming msgsResult ->
            ( { model | messages = msgsResult }, Cmd.none )

        PollMessages ->
            ( model, fetchMessages Incoming )

        Input say ->
            ( { model | saying = say }, Cmd.none )

        SetName name ->
            ( { model | name = name }, Cmd.none )


prefetchMessages : Cmd Msg
prefetchMessages =
    Task.perform (always PollMessages) (Task.succeed ())



-- API


endpoint : String
endpoint =
    "/api/messages"


fetchMessages : (ChatList -> Msg) -> Cmd Msg
fetchMessages callback =
    Http.get endpoint incomingMessagesDecoder
        |> Http.send (callback << RemoteData.fromResult)


incomingMessagesDecoder : Decode.Decoder (List ChatMessage)
incomingMessagesDecoder =
    Decode.at [ "data" ] (Decode.list incomingMessageDecoder)


incomingMessageDecoder : Decode.Decoder ChatMessage
incomingMessageDecoder =
    Decode.map2 (\name message -> ChatMessage name message)
        (Decode.field "name" Decode.string)
        (Decode.field "message" Decode.string)


sendMessage : ChatMessage -> (RemoteData.WebData Decode.Value -> Msg) -> Cmd Msg
sendMessage chatMessage callback =
    Http.post endpoint (bodyToSend chatMessage) Decode.value
        |> Http.send (callback << RemoteData.fromResult)


bodyToSend : ChatMessage -> Http.Body
bodyToSend chatMessage =
    Http.jsonBody <| sendEncoder chatMessage


sendEncoder : ChatMessage -> Encode.Value
sendEncoder msg =
    Encode.object
        [ ( "message"
          , Encode.object
                [ ( "name", Encode.string msg.name )
                , ( "message", Encode.string msg.message )
                ]
          )
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Time.every (5 * Time.second) (always PollMessages)



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ stylesheet "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css"
        , node "style" [ type_ "text/css" ] [ text styles ]
        , row_ [ h1 [ class "col-xs-7" ] [ text "Elm Phoenix Chat" ], div [ class "col-xs-5" ] [] ]
        , row_ [ errors model.messages ]
        , row_ [ inputControls model ]
        , row_ [ messageList model.messages ]
        ]


inputControls : Model -> Html Msg
inputControls { name, saying } =
    fieldset []
        [ Html.form [ class "form-horizontal", onSubmit <| SendMessage name saying ]
            [ formGroup_ (labeledField "name" "Name" "Your Name" name SetName)
            , formGroup_ (labeledField "say" "Say" "Enter a message..." saying Input)
            , btnPrimary_ "Send"
            ]
        ]


labeledField : String -> String -> String -> String -> (String -> Msg) -> List (Html Msg)
labeledField id_ text_ placeholder_ value_ msg_ =
    [ label [ for id_, class "col-sm-1" ] [ text text_ ]
    , input [ id id_, class "form-control col-sm-9", placeholder placeholder_, value value_, onInput msg_ ] []
    ]


errors : RemoteData.WebData a -> Html b
errors messages =
    let
        content =
            case messages of
                RemoteData.NotAsked ->
                    []

                RemoteData.Loading ->
                    []

                RemoteData.Success _ ->
                    []

                RemoteData.Failure e ->
                    [ text <| toString e ]
    in
        p [ class "text-danger" ] content


messageList : ChatList -> Html a
messageList messages =
    case messages of
        RemoteData.NotAsked ->
            notTable "Loading..."

        RemoteData.Loading ->
            notTable "Loading..."

        RemoteData.Failure e ->
            notTable "Loading failed"

        RemoteData.Success s ->
            let
                messages_ =
                    s
                        |> List.reverse
                        |> List.take 30
                        |> List.map msgRow
            in
                zebraTable [ th [ class "col-xs-2" ] [ text "Name" ], th [] [ text "Message" ] ] messages_


msgRow : ChatMessage -> Html a
msgRow msg =
    tr []
        [ td [] [ em [] [ text msg.name ] ]
        , td [] [ text msg.message ]
        ]


stylesheet : String -> Html a
stylesheet href_ =
    node "link" [ rel "stylesheet", href href_ ] []


notTable : String -> Html a
notTable content =
    div [ class "col-xs-12" ]
        [ aside [] [ text content ]
        ]


row_ : List (Html a) -> Html a
row_ =
    div [ class "row" ]


formGroup_ : List (Html a) -> Html a
formGroup_ =
    div [ class "form-group" ]


btnPrimary_ : String -> Html a
btnPrimary_ label =
    button [ class "btn btn-primary" ] [ text label ]


zebraTable : List (Html a) -> List (Html a) -> Html a
zebraTable headers bodies =
    table
        [ class "table col-xs-10 table-striped" ]
        [ thead [] [ tr [] headers ]
        , tbody [] bodies
        ]



-- STYLES


styles : String
styles =
    """
    body {
      font-family: Helvetica;
    }

    h1 {
      font-weight: bolder;
      margin-top: 50px;
    }

    img {
      height: 135px;
      width: auto;
      margin-bottom: -36px;
    }

    .btn {
      width: 100px;
      margin-top: 25px;
      float: right;
    }

    label {
      font-size: 18px;
    }

    #say, #name {
      font-size: 16px;
      width: 90%;
      border-radius: 20px;
    }
    """
