{-
   **FirebaseGuestbook Demo**

   Working with ports to communicate between JavaScript and Elm.
   This demo allows users to save and delete records, and the data
   gets sent to Firebase. Additionally, you can open multiple browser
   windows and see that the data is updated in real-time.

   If you want to get this demo running locally, you'll have to
   configure a separate index.html file in addition to this Elm file.

   You can generate the JavaScript output for this Elm code by running:

   elm-make FirebaseGuestbook.elm --output elm.js

   Then you can import that into your index.html file along with a
   handful of configuration options that you can get from a Firebase
   account. Here is an example of what your HTML and JS could look like:

    <html>
    <body>
      <div id="elm-container"></div>
      <script src="https://www.gstatic.com/firebasejs/3.6.10/firebase.js"></script>
      <script src="elm.js"></script>
      <script>
        // Initialize elm application
        var app = Elm.Firebase.fullscreen();

        // Firebase configuration
        var config = {
          apiKey: "AIzaSyDFEr6ia2IIQnvNJFmuqrskQpmB9ecfR0U",
          authDomain: "elmfirebase-3afdf.firebaseapp.com",
          databaseURL: "https://elmfirebase-3afdf.firebaseio.com",
          storageBucket: "elmfirebase-3afdf.appspot.com",
          messagingSenderId: "624487101842"
        };

        // Initialize Firebase application
        var firebaseApp = firebase.initializeApp(config);
        var database = firebaseApp.database();

        // Firebase data handling functions
        function addCustomer(customer) {
          return database.ref("customers").push(customer);
        }

        function deleteCustomer(customer) {
          return database.ref("customers" + "/" + customer.id).remove();
        }

        function customerListener() {
          return database.ref("customers");
        }

        // Add customers and save to Firebase
        app.ports.addCustomer.subscribe(customerName => {
          console.log(customerName);
          addCustomer({name: customerName})
            .then(function(response) {
              console.log("Saved customer.");
              app.ports.customerSaved.send(response.key);
            },
            function(err) {
              console.log("Error: " + err);
            });
        });

        // Listen to Firebase for real-time changes
        var listener = customerListener();
        listener.on("child_added", function(data) {
          var customer = Object.assign({id: data.key}, data.val());
          app.ports.newCustomer.send(customer);
        });

        // Delete customer and update Firebase
        app.ports.deleteCustomer.subscribe(function(customer) {
          deleteCustomer(customer)
            .then(function(response) {
            }, function(err) {
              console.log("error:", err);
            });
        });
        listener.on("child_removed", function(data) {
          app.ports.customerDeleted.send(data.key);
        });
      </script>
    </body>
    </html>
-}


port module FirebaseGuestbook exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, type_, value)
import Html.Events exposing (onClick, onInput, onSubmit)


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
    { name : String
    , customers : List Customer
    , error : Maybe String
    , nextId : Int
    }


type alias Customer =
    { id : String
    , name : String
    }


initialModel : Model
initialModel =
    { name = ""
    , customers = []
    , error = Nothing
    , nextId = 1
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )



-- UPDATE


type Msg
    = NoOp
    | NameInput String
    | SaveCustomer
    | CustomerSaved String
    | CustomerAdded Customer
    | DeleteCustomer Customer
    | CustomerDeleted String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        NameInput name ->
            ( { model | name = name }, Cmd.none )

        SaveCustomer ->
            ( model, addCustomer model.name )

        CustomerSaved key ->
            ( { model | name = "" }, Cmd.none )

        CustomerAdded customer ->
            let
                newCustomers =
                    customer :: model.customers
            in
                ( { model | customers = newCustomers }, Cmd.none )

        DeleteCustomer customer ->
            ( model, deleteCustomer customer )

        CustomerDeleted id ->
            let
                newCustomers =
                    model.customers
                        |> List.filter (\c -> c.id /= id)
            in
                ( { model | customers = newCustomers }, Cmd.none )



--VIEW


view : Model -> Html Msg
view model =
    div []
        [ node "style" [ type_ "text/css" ] [ text styles ]
        , h1 [] [ text "Firebase Guestbook" ]
        , viewCustomerForm model
        , viewCustomers model.customers
        ]


viewCustomer : Customer -> Html Msg
viewCustomer customer =
    li []
        [ span [ class "delete", DeleteCustomer customer |> onClick ] [ text " X " ]
        , text customer.name
        ]


viewCustomers : List Customer -> Html Msg
viewCustomers customers =
    customers
        |> List.sortBy .id
        |> List.map viewCustomer
        |> ul []


viewCustomerForm : Model -> Html Msg
viewCustomerForm model =
    Html.form [ onSubmit SaveCustomer ]
        [ input [ type_ "text", onInput NameInput, value model.name ] []
        , model.error
            |> Maybe.withDefault ""
            |> text
        , button [ type_ "submit" ] [ text "Save" ]
        ]



-- PORTS


port addCustomer : String -> Cmd msg


port customerSaved : (String -> msg) -> Sub msg


port newCustomer : (Customer -> msg) -> Sub msg


port deleteCustomer : Customer -> Cmd msg


port customerDeleted : (String -> msg) -> Sub msg



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ customerSaved CustomerSaved
        , newCustomer CustomerAdded
        , customerDeleted CustomerDeleted
        ]



-- STYLES


styles : String
styles =
    """
    body { font-family: Helvetica; }
    li { font-size: 1.2em; }
    .delete { font-family: Verdana; font-weight: bold; }
    """
