{-
   **ElmojiTranslator**

   Fun demo for translating input text into emoji (or translating emojis back
   into text). All the components have been combined into a single file here,
   but check out the ElmBridge curriculum for a step-by-step walkthrough of how
   to implement this demo in a more modular manner:
   https://elmbridge.github.io/curriculum/
-}


module ElmojiTranslator exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Char
import Dict
import List.Extra
import Regex
import String


-- MAIN


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = init
        , view = view
        , update = update
        }



-- MODEL


type alias Model =
    { currentText : String
    , direction : Direction
    }


type Direction
    = TextToEmoji
    | EmojiToText


type alias Key =
    String


init : Model
init =
    { currentText = ""
    , direction = TextToEmoji
    }


defaultKey : String
defaultKey =
    "😁"



-- UPDATE


type Msg
    = SetCurrentText String
    | ToggleDirection


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetCurrentText newText ->
            { model | currentText = newText }

        ToggleDirection ->
            case model.direction of
                TextToEmoji ->
                    { model | direction = EmojiToText }

                EmojiToText ->
                    { model | direction = TextToEmoji }



-- VIEW


view : Model -> Html Msg
view model =
    div
        []
        [ node "style" [ type_ "text/css" ] [ text styles ]
        , node
            "link"
            [ rel "stylesheet"
            , href "https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.7/css/materialize.min.css"
            ]
            []
        , nav
            []
            [ div
                [ class "nav-wrapper light-blue lighten-2" ]
                [ div
                    [ class "brand-logo center" ]
                    [ text "Elmoji Translator" ]
                ]
            ]
        , section
            [ class "container" ]
            [ div
                [ class "input-field" ]
                [ input
                    [ type_ "text"
                    , class "center"
                    , placeholder "Let's Translate!"
                    , onInput SetCurrentText
                    ]
                    []
                ]
            , div [ class "switch center" ]
                [ label []
                    [ text "Translate Text"
                    , input [ type_ "checkbox" ] []
                    , span
                        [ class "lever"
                        , onClick ToggleDirection
                        ]
                        []
                    , text "Translate Emoji"
                    ]
                ]
            , p
                [ class "center output-text emoji-size" ]
                [ text (translateText model) ]
            ]
        ]


translateText : Model -> String
translateText model =
    case model.direction of
        TextToEmoji ->
            textToEmoji defaultKey model.currentText

        EmojiToText ->
            emojiToText defaultKey model.currentText



-- STYLES


styles : String
styles =
    """
    .output-text {
      white-space: pre-wrap;
      line-height: 1.5;
    }

    .emoji-size {
      font-size: 3em;
    }

    .key-selector {
      display: inline-block;
      height: 1.3em;
      padding: 0 0.1em;
      border-radius: 20px;
    }

    .key-selector:not(.is-selected):hover {
      background-color: #4fc3f7;
      opacity: 0.3;
    }

    .key-selector.is-selected {
      background-color: #4fc3f7;
    }
    """



-- EMOJICONVERTER


textToEmoji : Key -> String -> String
textToEmoji key text =
    convert supportedLetters (rotateEmojis key) (Regex.regex "") text


emojiToText : Key -> String -> String
emojiToText key emojis =
    let
        splitter =
            (Regex.regex "([\\uD800-\\uDBFF][\\uDC00-\\uDFFF])")
    in
        convert (rotateEmojis key) supportedLetters splitter emojis


convert : List String -> List String -> Regex.Regex -> String -> String
convert orderedKeys orderedValues splitter string =
    let
        lookupTable =
            List.Extra.zip orderedKeys orderedValues
                |> Dict.fromList

        getValueOrReturnKey key =
            lookupTable
                |> Dict.get key
                |> Maybe.withDefault key
    in
        string
            |> Regex.split Regex.All splitter
            |> List.map (getValueOrReturnKey)
            |> String.join ""


rotateEmojis : Key -> List String
rotateEmojis key =
    supportedEmojis
        |> List.Extra.elemIndex key
        -- if the key can't be found, default to the first emoji listed.
        |>
            Maybe.withDefault 0
        |> (flip List.Extra.splitAt supportedEmojis)
        |> (\( head, tail ) -> [ tail, head ])
        |> List.concat


supportedLetters : List String
supportedLetters =
    [ -- lowercase letters
      List.range 97 122
      -- uppercase letters
    , List.range 65 90
      -- numbers
    , List.range 48 57
    ]
        |> List.concat
        |> List.map Char.fromCode
        |> List.map String.fromChar


supportedEmojis : List String
supportedEmojis =
    [ "😁"
    , "😂"
    , "😃"
    , "😄"
    , "😅"
    , "😆"
    , "😉"
    , "😊"
    , "😋"
    , "😌"
    , "😍"
    , "😏"
    , "😒"
    , "😓"
    , "😔"
    , "😖"
    , "😘"
    , "😚"
    , "😜"
    , "😝"
    , "😞"
    , "😠"
    , "😡"
    , "😢"
    , "😣"
    , "😤"
    , "😥"
    , "😨"
    , "😩"
    , "😪"
    , "😫"
    , "😭"
    , "😰"
    , "😱"
    , "😲"
    , "😳"
    , "😵"
    , "😷"
    , "😸"
    , "😹"
    , "😺"
    , "😻"
    , "😼"
    , "😽"
    , "😾"
    , "😿"
    , "🙀"
    , "🙅"
    , "🙆"
    , "🙇"
    , "🙈"
    , "🙉"
    , "🙊"
    , "🙋"
    , "🙌"
    , "🙍"
    , "🙎"
    , "🙏"
    , "🚑"
    , "🚒"
    , "🚓"
    , "🚕"
    ]
