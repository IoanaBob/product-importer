# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :product_importer,
  ecto_repos: [ProductImporter.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :product_importer, ProductImporterWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "HAG7iET6UI106E0asIWXLgsRNYX18m1M8j5pBmR6xV6/D7SlYl7jbaXsuRuXmZfd",
  render_errors: [view: ProductImporterWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: ProductImporter.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
