# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :schools_api,
  ecto_repos: [SchoolsApi.Repo]

# Configures the endpoint
config :schools_api, SchoolsApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "N8MLltVL/gUKt04YgYpxLzw0GBf5I2VNSpaOvGhUUU3CWqZbVbg0F4usE6mVUakr",
  render_errors: [view: SchoolsApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: SchoolsApi.PubSub,
  live_view: [signing_salt: "X8JThVqH"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
