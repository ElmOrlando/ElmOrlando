{-
   **Elixir and Elm Demo**

   This is a lengthy example of how to set up an Elixir and Phoenix back-end
   with Elm on the front-end. It was given as a presentation for the Elm Orlando
   January 2017 meeting.

   We start by creating a very simple API for a "video game platform", which is
   basically just a list of players and their scores. We added some sample data
   before moving to the Elm side for our collaborative coding session.

   JSON Decoding and HTTP requests were also covered briefly, and we finished
   with a working fetch of data from the back-end to render on the front-end. We
   didn't have time to cover full CRUD functionality, so this might be
   available as a future Elm Orlando presentation idea.

   # Elixir and Elm!

   ### Overview

   - Simple video game platform
     - JSON API: List of players and scores
   - Stack
     - Back-end: Elixir and Phoenix
     - Front-end: Elm
   - Outline
     - I'll set up the project and build the back-end
     - We'll build the Elm front-end together

   ### Elixir Project

   - [ ] Show Elixir homepage: http://elixir-lang.org/
   - [ ] Simple installation: `brew install elixir`
   - [ ] Create new Elixir project: `mix new platform`
   - [ ] View contents of a default Elixir project: `cd platform && atom .`
     - `config/`
     - `lib/`
     - `test/`
   - [ ] Run `mix test` as example command
     - Note that both Elixir and Elm are compiled languages
     - Make note of `_build` and doctests
     - Write functions, docs, and tests at the same time!
   - [ ] Remove initial Elixir project: `cd .. && rm -rf platform`

   ### Phoenix Project

   - [ ] Show Phoenix guides: http://www.phoenixframework.org/
   - [ ] Create Phoenix project: `mix phoenix.new platform`
   - [ ] Create database: `cd platform && mix ecto.create`
     - While compiling, note similarities between Elixir and Phoenix with `atom .`
   - [ ] Start server: `mix phoenix.server`
   - [ ] Show homepage in the browser: http://localhost:4000/
   - [ ] Replace contents of `/web/templates/page/index.html.eex` with `<a href="/api/players">List of Players</a>`

   ### Adding a Thing

   - [ ] Show Phoenix docs in Hex: https://hexdocs.pm/phoenix/
   - [ ] Generate JSON resource: `mix phoenix.gen.json Player players username:string score:integer`
   - [ ] Add resource to `web/router.ex`: `resources "/players", PlayerController`
   - [ ] Stop Phoenix server temporarily and run migrations with `mix ecto.reset`
   - [ ] Restart server and view empty http://localhost:4000/api/players/
   - [ ] Create example records in `priv/repo/seeds.exs`

     ```elixir
     Platform.Repo.insert!(%Platform.Player{username: "one", score: 111})
     Platform.Repo.insert!(%Platform.Player{username: "two", score: 222})
     Platform.Repo.insert!(%Platform.Player{username: "three", score: 333})
     ```

   - [ ] Stop the server and seed the database with `mix ecto.reset`
   - [ ] View working back-end data at http://localhost:4000/api/players/

   ### Setting Up Elm

   - [ ] Show Elm and Phoenix blog post: [Setting Up Elm with Phoenix](https://medium.com/@diamondgfx/setting-up-elm-with-phoenix-be3a9f55bac2#.58r4ki6jl)
   - [ ] Install `elm` and `elm-brunch` with `npm install --save-dev elm elm-brunch`
   - [ ] Set up Elm folder and file: `mkdir web/elm && touch web/elm/Main.elm`
   - [ ] Configure `brunch-config.js` watched paths:

     ```javascript
     paths: {
       watched: [
         "web/elm",
         "web/static",
         "test/static"
       ],
       public: "priv/static"
     },
     ```

   - [ ] Configure `brunch-config.js` plugins for `elmBrunch`:

     ```javascript
     plugins: {
       babel: {
         ignore: [/web\/static\/vendor/]
       },
       elmBrunch: {
         elmFolder: "web/elm",
         mainModules: ["Main.elm"],
         outputFolder: "../static/vendor"
       }
     },
     ```

   - [ ] Replace `/web/templates/index.html.eex` with `<div id="elm-container"></div>`
   - [ ] Configure Elm application in `/web/static/js/app.js`:

     ```javascript
     const elmDiv = document.querySelector("#elm-container");
     const elmApp = Elm.Main.embed(elmDiv);
     ```

   - [ ] Create Elm application

     ```elm
     module Main exposing (..)

     import Html

     main =
         Html.text "List of Players"
     ```

   - [ ] Restart the Phoenix server, see Elm compilation, and view running application in the browser!

   ### Starter Elm Application

   ```elm
   module Main exposing (..)

   import Html exposing (..)


   -- MAIN


   main : Program Never Model Msg
   main =
       Html.program
           { init = init
           , view = view
           , update = update
           , subscriptions = subscriptions
           }



   -- MODEL


   type alias Model =
       { -- list of players
       }


   type alias Player =
       { -- player fields
       }


   init : ( Model, Cmd Msg )
   init =
       ( initialModel, Cmd.none )


   initialModel : Model
   initialModel =
       -- start with a hardcoded list of players
       {}



   -- UPDATE


   type Msg
       = NoOp


   update : Msg -> Model -> ( Model, Cmd Msg )
   update msg model =
       case msg of
           NoOp ->
               ( model, Cmd.none )



   -- SUBSCRIPTIONS


   subscriptions : Model -> Sub Msg
   subscriptions model =
       Sub.none



   -- VIEW


   view : Model -> Html Msg
   view model =
       div []
           [ ul []
               [-- render list of players
               ]
           ]


   viewPlayer : Player -> Html Msg
   viewPlayer player =
       li []
           [ -- render each player's username and score
             p [] [ text "" ]
           ]
   ```

   ### Elm Model

   - [ ] Fill in the `Model` type alias for our data. We'll want to use a list of `players` that has the type `List Player`.
   - [ ] Fill in the `Player` type alias to set up the `username` and `score` fields with the appropriate types.
   - [ ] Set up the `initialModel` with a couple of hardcoded players to use as data in our `view`.

   ### Elm View

   - [ ] Fill in the `view` function and use `List.map` to render our list of players with `viewPlayer`.
   - [ ] Fill in the `viewPlayer` function to show the player's `username` and `score`.

   ### Elm and JSON

   - [ ] Now let's fetch data from our API. To do that, we'll need to decode the JSON. Let's pull in `Json.Decode`:

     ```elm
     import Json.Decode as Decode
     ```

   ### HTTP

   - [ ] Since we need to work with HTTP requests, we'll also need to import the `Http` module. Add it to the list of dependencies and then run `elm-package install`:

     ```javascript
     "dependencies": {
         "elm-lang/core": "5.1.1 <= v < 6.0.0",
         "elm-lang/html": "2.0.0 <= v < 3.0.0",
         "elm-lang/http": "1.0.0 <= v < 2.0.0"
     },
     ```

   - [ ] Now we can import the Http module:

     ```elm
     import Http
     ```

   ### JSON Decoding

   - [ ] Let's open the `Json.Decode` docs for reference: http://package.elm-lang.org/packages/elm-lang/core/latest/Json-Decode
   - [ ] First, we'll start by decoding the individual player data with the `map2` and `field` functions:

     ```elm
     -- JSON Decoders

     decodePlayerData =
         Decode.map2 Player
             (Decode.field "username" Decode.string)
             (Decode.field "score" Decode.int)
     ```

   - [ ] Then we'll decode the list of players with the `list` function:

     ```elm
     decodePlayersList =
         Decode.list decodePlayerData
     ```

   - [ ] Lastly we'll decode the full JSON data field with the `at` function:

     ```elm
     decodePlayersFetch =
         Decode.at [ "data" ] decodePlayersList
     ```

   ### Fetching from the API

   - [ ] Now that we have our decoders, we can fetch from the API. This takes two steps. First, we create our HTTP request "recipe", and then we perform the actual HTTP request. Since we need to fetch, we'll start with `Http.get`:

     ```elm
     -- HTTP

     fetchPlayers =
         Http.get "/api/players" decodePlayersFetch
     ```

   - [ ] And we can pipe that into `Http.send` to perform the fetch:

     ```elm
     performPlayerFetch =
         fetchPlayers |> Http.send FetchPlayers
     ```

   ### Fetch Update Message

   - [ ] So we have our JSON decoded and our HTTP request, now we can set up our `update` function:

     ```elm
     -- UPDATE

     type Msg
         = NoOp
         | FetchPlayers (Result Http.Error (List Player))


     update : Msg -> Model -> ( Model, Cmd msg )
     update msg model =
         case msg of
             NoOp ->
                 ( model, Cmd.none )

             FetchPlayers (Ok newPlayers) ->
                 ( { model | players = newPlayers }, Cmd.none )

             FetchPlayers (Err _) ->
                 ( model, Cmd.none )
     ```

   ### Rendering the Results

   - [ ] For our initial model, now we can perform the fetch to grab our players!

     ```elm
     init : ( Model, Cmd Msg )
     init =
         ( initialModel, performPlayerFetch )
     ```

   - [ ] That means we can also remove the hardcoded data from our `initialModel` and use an empty list:

     ```elm
     initialModel : Model
     initialModel =
         { players = [] }
     ```

   ### Creating New Players

   - [ ] Now that we're sending data to our API, we'll also need to import the JSON encoding library:

     ```elm
     import Json.Encode as Encode
     ```

   - [ ] To create new players, we'll start out with a simple default player record:

     ```elm
     -- JSON Encoding

     defaultPlayer : Encode.Value
     defaultPlayer =
         Encode.object
             [ ( "player"
               , Encode.object
                     [ ( "username", Encode.string "Default" )
                     , ( "score", Encode.int 0 )
                     ]
               )
             ]
     ```

   - [ ] Now we can use the same recipe we used for fetching data to create a player. We'll start with the HTTP recipe, and since we're creating we'll need to use `Http.post`:

     ```elm
     createPlayer =
         Http.post "/api/players" (Http.jsonBody defaultPlayer) decodePlayerData
     ```

   - [ ] Now we'll use our recipe to perform the actual player creation:

     ```elm
     performPlayerCreation =
         createPlayer |> Http.send CreatePlayer
     ```

   ### Create Update Message

   - [ ] Add the update messages to handle the results of the HTTP post. Note that we'll cheat a little bit here by fetching the players list again.

     ```elm
   type Msg
       = NoOp
       | FetchPlayers (Result Http.Error (List Player))
       | CreatePlayer (Result Http.Error Player)


   update : Msg -> Model -> ( Model, Cmd Msg )
   update msg model =
       case msg of
           NoOp ->
               ( model, Cmd.none )

           FetchPlayers (Ok newPlayers) ->
               ( { model | players = newPlayers }, Cmd.none )

           FetchPlayers (Err _) ->
               ( model, Cmd.none )

           CreatePlayer (Ok player) ->
               ( model, performPlayerFetch )

           CreatePlayer (Err _) ->
               ( model, performPlayerFetch )
     ```

   ### Performing the Player Creation

   - [ ] To create new players, we'll start with a button to add a new default player:

     ```elm
     type Msg
         = NoOp
         | FetchPlayers (Result Http.Error (List Player))
         | CreatePlayer (Result Http.Error Player)
         | CreatePlayerButton


     update : Msg -> Model -> ( Model, Cmd Msg )
     update msg model =
         case msg of
             NoOp ->
                 ( model, Cmd.none )

             FetchPlayers (Ok newPlayers) ->
                 ( { model | players = newPlayers }, Cmd.none )

             FetchPlayers (Err _) ->
                 ( model, Cmd.none )

             CreatePlayer (Ok player) ->
                 ( model, performPlayerFetch )

             CreatePlayer (Err _) ->
                 ( model, performPlayerFetch )

             CreatePlayerButton ->
                 ( model, performPlayerCreation )
     ```

   ### Adding the Button to Create Players

   - [ ] Now we can create a view function at the bottom to create players:

     ```elm
     createPlayerButton : Html Msg
     createPlayerButton =
         button [] [ text "Create Default Player" ]
     ```

   - [ ] We'll need to import the `onClick` event handler:

     ```elm
     import Html.Events exposing (onClick)
     ```

   - [ ] Lastly, we can handle the clicks to create new default players!

     ```elm
     button [ onClick CreatePlayerButton ] [ text "Create Default Player" ]
     ```

   ### Next Time

   - In regards to full CRUD operations, we've covered creating and reading records. Next time we can work towards updating and destroying records, and do a deeper dive into JSON and HTTP.
-}


module ElixingAndElm exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Http
import Json.Decode as Decode
import Json.Encode as Encode


-- MAIN


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { players : List Player
    }


type alias Player =
    { username : String
    , score : Int
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, performPlayerFetch )


initialModel : Model
initialModel =
    { players = [] }



-- UPDATE


type Msg
    = NoOp
    | FetchPlayers (Result Http.Error (List Player))
    | CreatePlayer (Result Http.Error Player)
    | CreatePlayerButton


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        FetchPlayers (Ok newPlayers) ->
            ( { model | players = newPlayers }, Cmd.none )

        FetchPlayers (Err _) ->
            ( model, Cmd.none )

        CreatePlayer (Ok player) ->
            ( model, performPlayerFetch )

        CreatePlayer (Err _) ->
            ( model, performPlayerFetch )

        CreatePlayerButton ->
            ( model, performPlayerCreation )



-- JSON Decoders


decodePlayerData : Decode.Decoder Player
decodePlayerData =
    Decode.map2 Player
        (Decode.field "username" Decode.string)
        (Decode.field "score" Decode.int)


decodePlayersList : Decode.Decoder (List Player)
decodePlayersList =
    Decode.list decodePlayerData


decodePlayersFetch : Decode.Decoder (List Player)
decodePlayersFetch =
    Decode.at [ "data" ] decodePlayersList



-- JSON Encoding


defaultPlayer : Encode.Value
defaultPlayer =
    Encode.object
        [ ( "player"
          , Encode.object
                [ ( "username", Encode.string "Default" )
                , ( "score", Encode.int 0 )
                ]
          )
        ]



-- HTTP


fetchPlayers : Http.Request (List Player)
fetchPlayers =
    Http.get "/api/players" decodePlayersFetch


performPlayerFetch : Cmd Msg
performPlayerFetch =
    fetchPlayers |> Http.send FetchPlayers


createPlayer : Http.Request Player
createPlayer =
    Http.post "/api/players" (Http.jsonBody defaultPlayer) decodePlayerData


performPlayerCreation : Cmd Msg
performPlayerCreation =
    createPlayer |> Http.send CreatePlayer



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ p [] [ text warningText ]
        , ul [] (List.map viewPlayer model.players)
        , createPlayerButton
        ]


warningText : String
warningText =
    """
  Note that this demo requires a live back-end to properly fetch and create
  data. Learn more by checking out the instructions in the source code!
  """


viewPlayer : Player -> Html Msg
viewPlayer player =
    li []
        [ p [] [ text player.username ]
        , p [] [ text (toString player.score) ]
        ]


createPlayerButton : Html Msg
createPlayerButton =
    button [ onClick CreatePlayerButton ] [ text "Create Default Player" ]
