# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :radch, ecto_repos: [Radch.Repo]

# Configures the endpoint
config :radch, RadchWeb.Endpoint,
  load_from_system_env: true,
  url: [host: "localhost"],
  secret_key_base: "DKrYED3rjqybZ0GggD5MPUhVCmS+e3DD7amVam3SO2ETBWQiq4K+eylZD7iycrVy",
  render_errors: [view: RadchWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Radch.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
