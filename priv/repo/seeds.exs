# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Radch.Repo.insert!(%Radch.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Radch.{
  Repo,
  Ship
}

Repo.insert!(%Ship{
  name: "Justice of Toren",
  ship_class: "Justice"
})

Repo.insert!(%Ship{
  name: "Mercy of Kalr",
  ship_class: "Mercy"
})

Repo.insert!(%Ship{
  name: "Sword of Amaat",
  ship_class: "Sword"
})
