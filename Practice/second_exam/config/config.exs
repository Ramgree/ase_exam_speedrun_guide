# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :second_exam,
  ecto_repos: [SecondExam.Repo]

# Configures the endpoint
config :second_exam, SecondExamWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "bG6rVSe2ylFcT0I+RevQhFtMRNZA4MHi5doH9SgAnjSp216mcmRsoeX6LC8rlr6X",
  render_errors: [view: SecondExamWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: SecondExam.PubSub,
  live_view: [signing_salt: "UPjXf/nM"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :second_exam, SecondExam.Guardian,
  issuer: "parkingproject",
  secret_key: "hnBIlgb6IhfXChBBSj6P/y64gDxuD8eiQVDcGXBsCT1+omX+Xy8K/6lZyaJs2ezV"
