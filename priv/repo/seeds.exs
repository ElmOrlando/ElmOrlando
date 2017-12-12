# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ElmOrlando.Repo.insert!(%ElmOrlando.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# Aliases

alias ElmOrlando.Demo
alias ElmOrlando.Message
alias ElmOrlando.Presentation
alias ElmOrlando.Repo
alias ElmOrlando.Resource

# Demo Data

Repo.insert!(%Demo{name: "HelloWorld", category: "example", liveDemoUrl: "/demos/HelloWorld.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/HelloWorld.elm"})
Repo.insert!(%Demo{name: "Counter", category: "example", liveDemoUrl: "/demos/Counter.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/Counter.elm"})
Repo.insert!(%Demo{name: "CalorieCounter", category: "example", liveDemoUrl: "/demos/CalorieCounter.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/CalorieCounter.elm"})
Repo.insert!(%Demo{name: "GuessingGame", category: "example", liveDemoUrl: "/demos/GuessingGame.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/GuessingGame.elm"})
Repo.insert!(%Demo{name: "RocketLaunch", category: "example", liveDemoUrl: "/demos/RocketLaunch.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/RocketLaunch.elm"})
Repo.insert!(%Demo{name: "UfoLanding", category: "example", liveDemoUrl: "/demos/UfoLanding.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/UfoLanding.elm"})
Repo.insert!(%Demo{name: "Train", category: "example", liveDemoUrl: "/demos/Train.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/Train.elm"})
Repo.insert!(%Demo{name: "ElmMario", category: "example", liveDemoUrl: "/demos/ElmMario.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/ElmMario.elm"})
Repo.insert!(%Demo{name: "ElmOrlando", category: "example", liveDemoUrl: "/demos/ElmOrlando.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/ElmOrlando.elm"})
Repo.insert!(%Demo{name: "Clock", category: "example", liveDemoUrl: "/demos/Clock.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/Clock.elm"})
Repo.insert!(%Demo{name: "RandomDice", category: "example", liveDemoUrl: "/demos/RandomDice.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/RandomDice.elm"})
Repo.insert!(%Demo{name: "GifFetch", category: "example", liveDemoUrl: "/demos/GifFetch.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/GifFetch.elm"})
Repo.insert!(%Demo{name: "ScoreKeeper", category: "example", liveDemoUrl: "/demos/ScoreKeeper.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/ScoreKeeper.elm"})
Repo.insert!(%Demo{name: "Routing", category: "example", liveDemoUrl: "/demos/Routing.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/Routing.elm"})
Repo.insert!(%Demo{name: "MessageBoard", category: "example", liveDemoUrl: "/demos/MessageBoard.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/MessageBoard.elm"})
Repo.insert!(%Demo{name: "FirebaseGuestbook", category: "example", liveDemoUrl: "/demos/FirebaseGuestbook.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/FirebaseGuestbook.elm"})
Repo.insert!(%Demo{name: "ListCreator", category: "live", liveDemoUrl: "/demos/ListCreator.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/ListCreator.elm"})
Repo.insert!(%Demo{name: "MouseFollow", category: "live", liveDemoUrl: "/demos/MouseFollow.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/MouseFollow.elm"})
Repo.insert!(%Demo{name: "ElixirAndElm", category: "live", liveDemoUrl: "/demos/ElixirAndElm.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/ElixirAndElm.elm"})
Repo.insert!(%Demo{name: "ApiFetch", category: "live", liveDemoUrl: "/demos/ApiFetch.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/ApiFetch.elm"})
Repo.insert!(%Demo{name: "RandomCompliments", category: "live", liveDemoUrl: "https://embed.ellie-app.com/WQRynbyYDVa1/5", sourceCodeUrl: "https://ellie-app.com/WQRynbyYDVa1/5"})
Repo.insert!(%Demo{name: "AdventOfCode", category: "live", liveDemoUrl: "/demos/AdventOfCode.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/AdventOfCode.elm"})

# Resource Data

Repo.insert!(%Resource{name: "An Introduction to Elm", category: "book", url: "http://guide.elm-lang.org"})
Repo.insert!(%Resource{name: "Beginning Elm", category: "book", url: "http://elmprogramming.com"})
Repo.insert!(%Resource{name: "ElmBridge Curriculum", category: "book", url: "https://raorao.gitbooks.io/elmbridge-curriculum/content"})
Repo.insert!(%Resource{name: "Elm for Beginners", category: "course", url: "http://courses.knowthen.com/courses/elm-for-beginners"})
Repo.insert!(%Resource{name: "DailyDrip Elm", category: "course", url: "https://www.dailydrip.com/topics/elm"})
Repo.insert!(%Resource{name: "Elm Slack", category: "community", url: "http://elmlang.herokuapp.com"})
Repo.insert!(%Resource{name: "Elm Twitter", category: "community", url: "https://twitter.com/elmlang"})

# Presentation Data

Repo.insert!(%Presentation{name: "Getting to Know Elm", category: "September 2016", author: "Bijan Boustani", url: "http://prezi.com/wofdk8e6uuy3"})
Repo.insert!(%Presentation{name: "React and Elm", category: "October 2016", author: "David Khourshid", url: ""})
Repo.insert!(%Presentation{name: "Solving a Problem with Elm", category: "November 2016", author: "Bijan Boustani", url: "https://prezi.com/f0lpwk_xlj4p"})
Repo.insert!(%Presentation{name: "Input and Subscriptions", category: "December 2016", author: "AJ Foster", url: "https://cl.ly/0U2n0R3J3A2t"})
Repo.insert!(%Presentation{name: "Level Up with FP", category: "January 2017", author: "Devan Kestel", url: "https://cl.ly/301L3s130H01"})
Repo.insert!(%Presentation{name: "Elixir and Elm", category: "January 2017", author: "Bijan Boustani", url: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/ElixirAndElm.elm"})
Repo.insert!(%Presentation{name: "Elm and Firebase", category: "February 2017", author: "Rob Bethencourt", url: "http://slides.com/robertbethencourt/my-first-slide"})
Repo.insert!(%Presentation{name: "Introducing Ellie", category: "March 2017", author: "Bijan Boustani", url: "https://ellie-app.com/new"})
Repo.insert!(%Presentation{name: "Handling Failure in Elm", category: "April 2017", author: "Justin Mimbs", url: "https://cl.ly/170x160V1L1Y"})
Repo.insert!(%Presentation{name: "Creating with Elm – Part I", category: "May 2017", author: "", url: "https://github.com/ElmOrlando/ElmGeolocation"})
Repo.insert!(%Presentation{name: "Creating with Elm – Part II", category: "June 2017", author: "", url: "https://github.com/ElmOrlando/ElmGeolocation"})
Repo.insert!(%Presentation{name: "Creating with Elm – Part III", category: "July 2017", author: "", url: "https://youtu.be/QXrUST6v2yg"})
Repo.insert!(%Presentation{name: "Hack Night", category: "August 2017", author: "", url: "https://youtu.be/dZlEhZgBK3E"})
Repo.insert!(%Presentation{name: "Show & Tell", category: "September 2017", author: "", url: "https://youtu.be/mrGmLuwDPOg"})

# Message Data

Repo.insert!(%Message{name: "Bijan", message: "Hello, world."})