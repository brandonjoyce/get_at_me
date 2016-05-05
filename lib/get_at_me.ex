defmodule GetAtMe do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    if Enum.any?([
      System.get_env("GITHUB_CLIENT_ID"),
      System.get_env("GITHUB_CLIENT_SECRET"),
    ], fn(x) -> is_nil(x) end) do
      raise "You need to set these ENV variables"
    end

    children = [
      # Start the endpoint when the application starts
      supervisor(GetAtMe.Endpoint, []),
      # Start the Ecto repository
      supervisor(GetAtMe.Repo, []),
      # Here you could define other workers and supervisors as children
      # worker(GetAtMe.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GetAtMe.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    GetAtMe.Endpoint.config_change(changed, removed)
    :ok
  end
end
