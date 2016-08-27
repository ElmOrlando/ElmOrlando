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
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "Hello World", liveDemoUrl: "#", sourceCodeUrl: "#"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "Counter", liveDemoUrl: "#", sourceCodeUrl: "#"})
ElmOrlando.Repo.insert!(%ElmOrlando.Demo{name: "Mario", liveDemoUrl: "#", sourceCodeUrl: "#"})
