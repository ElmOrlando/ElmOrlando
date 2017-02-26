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

# Demo Data

ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "HelloWorld", category: "example", liveDemoUrl: "/demos/HelloWorld.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/HelloWorld.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "Counter", category: "example", liveDemoUrl: "/demos/Counter.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/Counter.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "CalorieCounter", category: "example", liveDemoUrl: "/demos/CalorieCounter.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/CalorieCounter.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "GuessingGame", category: "example", liveDemoUrl: "/demos/GuessingGame.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/GuessingGame.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "RocketLaunch", category: "example", liveDemoUrl: "/demos/RocketLaunch.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/RocketLaunch.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "UfoLanding", category: "example", liveDemoUrl: "/demos/UfoLanding.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/UfoLanding.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "Train", category: "example", liveDemoUrl: "/demos/Train.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/Train.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "ElmMario", category: "example", liveDemoUrl: "/demos/ElmMario.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/ElmMario.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "ElmOrlando", category: "example", liveDemoUrl: "/demos/ElmOrlando.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/ElmOrlando.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "Clock", category: "example", liveDemoUrl: "/demos/Clock.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/Clock.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "RandomDice", category: "example", liveDemoUrl: "/demos/RandomDice.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/RandomDice.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "GifFetch", category: "example", liveDemoUrl: "/demos/GifFetch.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/GifFetch.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "ScoreKeeper", category: "example", liveDemoUrl: "/demos/ScoreKeeper.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/ScoreKeeper.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "Routing", category: "example", liveDemoUrl: "/demos/Routing.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/Routing.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "MessageBoard", category: "example", liveDemoUrl: "/demos/MessageBoard.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/MessageBoard.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "FirebaseGuestbook", category: "example", liveDemoUrl: "/demos/FirebaseGuestbook.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/FirebaseGuestbook.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "ListCreator", category: "live", liveDemoUrl: "/demos/ListCreator.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/ListCreator.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "MouseFollow", category: "live", liveDemoUrl: "/demos/MouseFollow.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/MouseFollow.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "ElixirAndElm", category: "live", liveDemoUrl: "/demos/ElixirAndElm.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/ElixirAndElm.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "ApiFetch", category: "live", liveDemoUrl: "/demos/ApiFetch.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/ApiFetch.elm"})

# Resource Data

ElmOrlando.Repo.insert!(%ElmOrlando.Resource{name: "An Introduction to Elm", category: "book", url: "http://guide.elm-lang.org"})
ElmOrlando.Repo.insert!(%ElmOrlando.Resource{name: "Beginning Elm", category: "book", url: "http://elmprogramming.com"})
ElmOrlando.Repo.insert!(%ElmOrlando.Resource{name: "ElmBridge Curriculum", category: "book", url: "https://raorao.gitbooks.io/elmbridge-curriculum/content"})
ElmOrlando.Repo.insert!(%ElmOrlando.Resource{name: "Elm for Beginners", category: "course", url: "http://courses.knowthen.com/courses/elm-for-beginners"})
ElmOrlando.Repo.insert!(%ElmOrlando.Resource{name: "DailyDrip Elm", category: "course", url: "https://www.dailydrip.com/topics/elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Resource{name: "Elm Slack", category: "community", url: "http://elmlang.herokuapp.com"})
ElmOrlando.Repo.insert!(%ElmOrlando.Resource{name: "Elm Twitter", category: "community", url: "https://twitter.com/elmlang"})
ElmOrlando.Repo.insert!(%ElmOrlando.Resource{name: "Elm Weekly", category: "community", url: "http://www.elmweekly.nl"})

# Presentation Data

ElmOrlando.Repo.insert!(%ElmOrlando.Presentation{name: "Getting to Know Elm", category: "September 2016", author: "Bijan Boustani", url: "http://prezi.com/wofdk8e6uuy3"})
ElmOrlando.Repo.insert!(%ElmOrlando.Presentation{name: "React and Elm", category: "October 2016", author: "David Khourshid", url: ""})
ElmOrlando.Repo.insert!(%ElmOrlando.Presentation{name: "Solving a Problem with Elm", category: "November 2016", author: "Bijan Boustani", url: "https://prezi.com/f0lpwk_xlj4p"})
ElmOrlando.Repo.insert!(%ElmOrlando.Presentation{name: "Input and Subscriptions", category: "December 2016", author: "AJ Foster", url: "https://d17oy1vhnax1f7.cloudfront.net/items/3X3A1q0u372R1g39083G/input_and_subscriptions.pdf"})
ElmOrlando.Repo.insert!(%ElmOrlando.Presentation{name: "Level Up with FP", category: "January 2017", author: "Devan Kestel", url: "https://d17oy1vhnax1f7.cloudfront.net/items/2P2g0U241T3s0i213G3y/level_up_with_fp.pdf"})
ElmOrlando.Repo.insert!(%ElmOrlando.Presentation{name: "Elixir and Elm", category: "January 2017", author: "Bijan Boustani", url: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/ElixirAndElm.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Presentation{name: "Elm and Firebase", category: "February 2017", author: "Rob Bethencourt", url: "http://slides.com/robertbethencourt/my-first-slide"})

# Message Data

ElmOrlando.Repo.insert!(%ElmOrlando.Message{name: "Bijan", message: "Hello, world."})