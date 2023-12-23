import Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we can use it
# to bundle .js and .css sources.
config :<%= @app_name %>, <%= @endpoint_module %>,
  # Binding to loopback ipv4 address prevents access from other machines.
  # Change to `ip: {0, 0, 0, 0}` to allow access from other machines.
  http: [ip: {127, 0, 0, 1}, port: 4000],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "<%= @secret_key_base_dev %>",
  watchers: <%= if @javascript or @css do %>[<%= if @javascript do %>
    esbuild: {Esbuild, :install_and_run, [:default, ~w(--sourcemap=inline --watch)]}<%= if @css, do: "," %><% end %><%= if @css do %>
    tailwind: {Tailwind, :install_and_run, [:default, ~w(--watch)]}<% end %>
  ]<% else %>[]<% end %>

# ## SSL Support
#
# In order to use HTTPS in development, a self-signed
# certificate can be generated by running the following
# Mix task:
#
#     mix phx.gen.cert
#
# Run `mix help phx.gen.cert` for more information.
#
# The `http:` config above can be replaced with:
#
#     https: [
#       port: 4001,
#       cipher_suite: :strong,
#       keyfile: "priv/cert/selfsigned_key.pem",
#       certfile: "priv/cert/selfsigned.pem"
#     ],
#
# If desired, both `http:` and `https:` keys can be
# configured to run both http and https servers on
# different ports.<%= if @html do %>

# Watch static and templates for browser reloading.
config :<%= @app_name %>, <%= @endpoint_module %>,
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",<%= if @gettext do %>
      ~r"priv/gettext/.*(po)$",<% end %>
      ~r"lib/<%= @lib_web_name %>/(controllers|live|components)/.*(ex|heex)$"
    ]
  ]<% end %>

# Enable dev routes for dashboard and mailbox
config :<%= @app_name %>, dev_routes: true

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime<%= if @html do %>

# Include HEEx debug annotations as HTML comments in rendered markup
config :phoenix_live_view, :debug_heex_annotations, true<% end %><%= if @mailer do %>

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false<% end %>
