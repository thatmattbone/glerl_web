defmodule Glerl.Web.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Glerl.Web.Telemetry,
      {DNSCluster, query: Application.get_env(:glerl_web, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Glerl.Web.PubSub},
      # Start a worker by calling: Glerl.Web.Worker.start_link(arg)
      # {Glerl.Web.Worker, arg},
      # Start to serve requests, typically the last entry
      Glerl.Web.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Glerl.Web.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    Glerl.Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
