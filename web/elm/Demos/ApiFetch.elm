{-
   **API Fetch Demo**

   This was a live coding session from the February meeting of Elm Orlando.
   Rather than using a checklist like we had previously done, we had a free
   form live coding where we talked about how to approach the problem and
   looked up documentation as needed to arrive at the result.

   The demo fetches live data from the Star Wars API (https://swapi.co/api/).
   We also added a selector to choose a film and view the live scroll of the
   opening crawl from each Star Wars movie.
-}


module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (id, class, value, selected)
import Html.Events exposing (onInput)
import Http
import Json.Decode as Decode exposing (Decoder)


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
    { films : List Film
    , selectedFilm : Int
    }


type alias Film =
    { episode_id : Int
    , title : String
    , opening_crawl : String
    }


initialModel : Model
initialModel =
    Model [] 1


init : ( Model, Cmd Msg )
init =
    ( initialModel
    , Http.get "//swapi.co/api/films" decodeFilms
        |> Http.send ReceivedFilms
    )


decodeFilms : Decoder (List Film)
decodeFilms =
    Decode.field "results" (Decode.list decodeFilm)


decodeFilm : Decoder Film
decodeFilm =
    Decode.map3 Film
        (Decode.field "episode_id" Decode.int)
        (Decode.field "title" Decode.string)
        (Decode.field "opening_crawl" Decode.string)



-- UPDATE


type Msg
    = ReceivedFilms (Result Http.Error (List Film))
    | SelectFilm Int


update : Msg -> Model -> ( Model, Cmd a )
update msg model =
    case msg of
        ReceivedFilms results ->
            case results of
                Ok films ->
                    ( { model
                        | films =
                            films
                                |> List.sortBy .episode_id
                                |> Debug.log "films"
                      }
                    , Cmd.none
                    )

                Err _ ->
                    ( initialModel, Cmd.none )

        SelectFilm id ->
            ( { model | selectedFilm = id }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view { films, selectedFilm } =
    let
        film : Maybe Film
        film =
            films
                |> List.filter (.episode_id >> (==) selectedFilm)
                |> List.head
    in
        div []
            [ viewSelector films selectedFilm
            , film
                |> Maybe.map viewFilm
                |> Maybe.withDefault (text "no film")
            ]


viewSelector : List Film -> Int -> Html Msg
viewSelector films selectedFilm =
    select [ onInput (String.toInt >> Result.withDefault 1 >> SelectFilm) ]
        (films
            |> List.map
                (\film ->
                    option
                        [ value (toString film.episode_id)
                        , selected (selectedFilm == film.episode_id)
                        ]
                        [ text film.title ]
                )
        )


viewFilm : Film -> Html a
viewFilm film =
    div []
        [ node "style" [] [ text css ]
        , div [ id "crawl" ]
            [ div [ id "text" ] [ text film.opening_crawl ]
            ]
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub a
subscriptions model =
    Sub.none



-- STYLES


css : String
css =
    """
    * {
      position: relative;
      box-sizing: border-box;
    }

    #crawl {
      color: gold;
      font-size: 9vmin;
      width: 50%;
      margin: 0 25%;
      transform: translate3d(0, 0, -200px) rotateX(32deg);
      transform-origin: top center;
    }

    #text {
      animation: crawl 45s linear infinite;
    }

    @keyframes crawl {
      from {
        transform: translateY(50%);
      }
      to {
        transform: translateY(-100%);
      }
    }

    body {
      font: Helvetica;
      height: 100%;
      width: 100%;
      padding: 0;
      margin: 0;
      background: url("https://d2v9y0dukr6mq2.cloudfront.net/video/thumbnail/4w8qfPNhgilfsnun8/stars-slowly-twinkle-in-the-night-sky_ejvleuenl__S0000.jpg");
      transform-style: preserve-3d;
      perspective: 1000px;
    }
    """
