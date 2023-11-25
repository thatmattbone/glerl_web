import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :glerl_web, Glerl.Web.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "wCk9OdHZ4eKMYcPbf7tiubfLcXGmV4t/UC//MaiU6yMo+Eq0vH//E147RX+mkeMU",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
