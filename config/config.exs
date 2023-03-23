# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :apiconsumer,
  ecto_repos: [Apiconsumer.Repo]

config :apiconsumer, ApiconsumerWeb.GetDataController,
  get_repos_adapter: Apiconsumer.GitHub.Client

# Configuração para determinar que a Pk do tipo UUID
config :apiconsumer, Apiconsumer.Repo, migration_primary_key: [type: :binary_id]

# Configuração para lib guardian
config :apiconsumer, ApiconsumerWeb.Auth.Guardian,
  issuer: "apiconsumer",
  secret_key: "XCvD3bE+o76K7cU2y5OpDANfQytPWA0gvs5m7bVdRhUQvPqo/oq68l0JtFTrFg2V"

# Configuração para utilizar o pipeline do guardian para usar rota autenticada
config :apiconsumer, ApiconsumerWeb.Auth.Pipeline,
  module: ApiconsumerWeb.Auth.Guardian,
  error_handler: ApiconsumerWeb.Auth.ErrorHandler

# Configures the endpoint
config :apiconsumer, ApiconsumerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "7CgZ0k+UxufCXTP52vc6K8/uh99FF+9oQT778TYQFYoYM3vqOkyosd54clkbzBt2",
  render_errors: [view: ApiconsumerWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Apiconsumer.PubSub,
  live_view: [signing_salt: "CvRS+QEm"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
