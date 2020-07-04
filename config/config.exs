# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :animal_api,
  ecto_repos: [AnimalApi.Repo]

# Configures the endpoint
config :animal_api, AnimalApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "bAt+tnS15iEy0OfQuJLMjt1lEFa/9VDuzTyGJU4BQgSduqI7edKYu09HO6A25qUX",
  render_errors: [view: AnimalApiWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: AnimalApi.PubSub,
  live_view: [signing_salt: "PJVPlDmb"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
