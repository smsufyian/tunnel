defmodule Tunnel.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TunnelWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:tunnel, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Tunnel.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Tunnel.Finch},
      # Start a worker by calling: Tunnel.Worker.start_link(arg)
      # {Tunnel.Worker, arg},
      # Start to serve requests, typically the last entry
      TunnelWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Tunnel.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TunnelWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
