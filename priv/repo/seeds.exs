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
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "HelloWorld", liveDemoUrl: "/demos/HelloWorld.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/HelloWorld.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "Counter", liveDemoUrl: "/demos/Counter.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/Counter.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "CalorieCounter", liveDemoUrl: "/demos/CalorieCounter.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/CalorieCounter.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "GuessingGame", liveDemoUrl: "/demos/GuessingGame.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/GuessingGame.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "RocketLaunch", liveDemoUrl: "/demos/RocketLaunch.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/RocketLaunch.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "UfoLanding", liveDemoUrl: "/demos/UfoLanding.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/UfoLanding.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "Train", liveDemoUrl: "/demos/Train.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/Train.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "ElmOrlando", liveDemoUrl: "/demos/ElmOrlando.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/ElmOrlando.elm"})
