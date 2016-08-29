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
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "ElmOrlando", liveDemoUrl: "/demos/ElmOrlando.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/ElmOrlando.elm"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "GuessingGame", liveDemoUrl: "/demos/GuessingGame.html", sourceCodeUrl: "https://github.com/ElmOrlando/ElmOrlando/blob/master/web/elm/Demos/GuessingGame.elm"})
