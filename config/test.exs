use Mix.Config

config :logger, level: :warn

config :virtual_fields_filler,
  ecto_repos: [VirtualFieldsFiller.Repo]

config :virtual_fields_filler, VirtualFieldsFiller.Repo,
  username: "postgres",
  password: "postgres",
  database: "virtual_fields_filler_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  priv: "test/support"
