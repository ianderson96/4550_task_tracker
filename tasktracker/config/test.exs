use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :tasktracker, TasktrackerWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :tasktracker, Tasktracker.Repo,
  username: "tasktracker",
  password: "noo4Ufov1Lat",
  database: "tasktracker_dev",
  hostname: "localhost",
  pool_size: 10,
  pool: Ecto.Adapters.SQL.Sandbox
