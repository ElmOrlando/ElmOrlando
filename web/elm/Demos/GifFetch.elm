{-
   **GifFetch Demo**

   Example using Task.perform to fetch a gif from giphy's API with Http.get.
   Also uses Json to decode the response.
-}


module GifFetch exposing (..)

import Html.App as App
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Json
import Task


-- MAIN


main : Program Never
main =
    App.program
        { init = init "Dogs"
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { topic : String
    , gifUrl : String
    }


init : String -> ( Model, Cmd Msg )
init topic =
    ( Model topic "/images/waiting.gif"
    , getRandomGif topic
    )



-- UPDATE


type Msg
    = MorePlease
    | FetchSucceed String
    | FetchFail Http.Error


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MorePlease ->
            ( model, getRandomGif model.topic )

        FetchSucceed newUrl ->
            ( Model model.topic newUrl, Cmd.none )

        FetchFail _ ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div
        [ style
            [ ( "font-family", "Helvetica" )
            , ( "font-size", "40px" )
            , ( "margin-left", "40px" )
            ]
        ]
        [ h1 [] [ text model.topic ]
        , img [ src model.gifUrl ] []
        , br [] []
        , button [ onClick MorePlease ] [ text "Fetch New Gif" ]
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- HTTP


getRandomGif : String -> Cmd Msg
getRandomGif topic =
    let
        url =
            "http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic
    in
        Task.perform FetchFail FetchSucceed (Http.get decodeGifUrl url)


decodeGifUrl : Json.Decoder String
decodeGifUrl =
    Json.at [ "data", "image_url" ] Json.string
