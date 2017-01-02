defmodule CowboySampleOne do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(__MODULE__, [], function: :run)
    ]

    opts = [strategy: :one_for_one, name: CowboySampleOne.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def run do
    routes = [
      {"/api/:hello", CowboySampleOne.Handler, []}
    ]

    dispatch = :cowboy_router.compile([{:_, routes}])

    opts = [port: 4000]
    env = [dispatch: dispatch]

    {:ok, _pid} = :cowboy.start_http(:http, 100, opts, [env: env])
  end
end
