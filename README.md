# Elm Orlando

Elm meetups and hack nights in Orlando! No previous Elm experience required.

This repository contains the source code for the
[Elm Orlando](https://elmorlando.herokuapp.com) site, which is intended as a
central location for presentations, demos, resources, etc.

## Requirements

- Elm 0.18.0
- Phoenix 1.2
- Elixir 1.4

## Setup Instructions

1. `git clone https://github.com/ElmOrlando/ElmOrlando.git`
2. `mix deps.get` to install Phoenix dependencies.
3. `config/dev.exs` and `config/test.exs` to configure local database.
4. `mix ecto.setup` to create, migrate, and seed the database.
5. `npm install` to install Node dependencies.
6. `mix phoenix.server` to start Phoenix server.
7. `localhost:4000` to see application!

## Deployment

This app is deployed to Heroku at https://elmorlando.herokuapp.com.

## Contributing

Check out the [GitHub Issues](https://github.com/ElmOrlando/ElmOrlando/issues)
to see what is currently on deck.

