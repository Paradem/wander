# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :wander, Wander.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "a3dp6D0rlE8j65iuBm9Er/XoF5wRZU+x8nCtgXJYNMYLWg0Av36nFYawxRaRH7TF",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: Wander.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :wander, BeaconElixir.Repo,
  adapter: Ecto.Adapters.Postgres,
  extensions: [{Postgrex.Extensions.Point, []}]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false
