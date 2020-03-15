# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :gift_list,
  ecto_repos: [GiftList.Repo]

# Configures the endpoint
config :gift_list, GiftListWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "va4EZSU+auBYria4aPV85xBvbIUfcp5rFxdKi3tJBYup/3WpR8bPsZUJckFUbcDF",
  render_errors: [view: GiftListWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: GiftList.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures the live view
config :gift_list, GiftListWeb.Endpoint,
       live_view: [
         signing_salt: "Y0Hn9Zn3GrNm1Vk/KTrlNOIHAStdJhFP"
       ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
