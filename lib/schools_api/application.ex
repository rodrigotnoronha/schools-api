defmodule SchoolsApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      SchoolsApi.Repo,
      # Start the Telemetry supervisor
      SchoolsApiWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: SchoolsApi.PubSub},
      # Start the Endpoint (http/https)
      SchoolsApiWeb.Endpoint
      # Start a worker by calling: SchoolsApi.Worker.start_link(arg)
      # {SchoolsApi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SchoolsApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    SchoolsApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
