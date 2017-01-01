defmodule PhoenixDemo.Router do
  use PhoenixDemo.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PhoenixDemo do
    pipe_through :api

    post "/hello", HelloController, :hello
  end
end
