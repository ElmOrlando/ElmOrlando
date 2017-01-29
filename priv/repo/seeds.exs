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

ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "HelloWorld", liveDemoUrl: "/demos/HelloWorld.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/HelloWorld.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "Counter", liveDemoUrl: "/demos/Counter.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/Counter.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "CalorieCounter", liveDemoUrl: "/demos/CalorieCounter.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/CalorieCounter.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "GuessingGame", liveDemoUrl: "/demos/GuessingGame.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/GuessingGame.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "RocketLaunch", liveDemoUrl: "/demos/RocketLaunch.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/RocketLaunch.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "UfoLanding", liveDemoUrl: "/demos/UfoLanding.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/UfoLanding.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "Train", liveDemoUrl: "/demos/Train.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/Train.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "ElmMario", liveDemoUrl: "/demos/ElmMario.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/ElmMario.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "ElmOrlando", liveDemoUrl: "/demos/ElmOrlando.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/ElmOrlando.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "Clock", liveDemoUrl: "/demos/Clock.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/Clock.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "RandomDice", liveDemoUrl: "/demos/RandomDice.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/RandomDice.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "GifFetch", liveDemoUrl: "/demos/GifFetch.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/GifFetch.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "ScoreKeeper", liveDemoUrl: "/demos/ScoreKeeper.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/ScoreKeeper.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "ElmojiTranslator", liveDemoUrl: "/demos/ElmojiTranslator.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/ElmojiTranslator.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "Routing", liveDemoUrl: "/demos/Routing.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/Routing.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "MessageBoard", liveDemoUrl: "/demos/MessageBoard.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/MessageBoard.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "ListCreator", liveDemoUrl: "/demos/ListCreator.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/ListCreator.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "MouseFollow", liveDemoUrl: "/demos/MouseFollow.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/MouseFollow.elm"})

# Resource Data

ElmOrlando.Repo.insert!(%ElmOrlando.Resource{name: "An Introduction to Elm", category: "book", url: "http://guide.elm-lang.org"})
ElmOrlando.Repo.insert!(%ElmOrlando.Resource{name: "Beginning Elm", category: "book", url: "http://elmprogramming.com"})
ElmOrlando.Repo.insert!(%ElmOrlando.Resource{name: "ElmBridge Curriculum", category: "book", url: "https://raorao.gitbooks.io/elmbridge-curriculum/content"})
ElmOrlando.Repo.insert!(%ElmOrlando.Resource{name: "Elm for Beginners", category: "course", url: "http://courses.knowthen.com/courses/elm-for-beginners"})
ElmOrlando.Repo.insert!(%ElmOrlando.Resource{name: "DailyDrip Elm", category: "course", url: "https://www.dailydrip.com/topics/elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Resource{name: "Elm Slack", category: "community", url: "http://elmlang.herokuapp.com"})
ElmOrlando.Repo.insert!(%ElmOrlando.Resource{name: "Elm Twitter", category: "community", url: "https://twitter.com/elmlang"})
ElmOrlando.Repo.insert!(%ElmOrlando.Resource{name: "Elm Weekly", category: "community", url: "http://www.elmweekly.nl"})

# Message Data

ElmOrlando.Repo.insert!(%ElmOrlando.Message{name: "Bijan", message: "Hello, world."})