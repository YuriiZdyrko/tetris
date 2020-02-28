# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :tetris,
  ecto_repos: [Tetris.Repo]

# Configures the endpoint
config :tetris, TetrisWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "6BJLdjEXbR3vhY/DZDET0x2EDUdYWJQ9ajr3OAaheL9N17NoPoJnq0z8AecrgNnB",
  render_errors: [view: TetrisWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Tetris.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "ZYO3A6Kq"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
