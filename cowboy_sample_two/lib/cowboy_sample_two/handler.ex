defmodule CowboySampleTwo.Handler do
  def init(req, state) do
    handle(req, state)
  end

  def handle(req, state) do
    method = :cowboy_req.method(req)
    {:ok, params, req} = :cowboy_req.body_qs(req)
    param = params |> Enum.at(0) |> elem(0)
    IO.inspect param
    {:ok, req} = get_request(method, param,req)
    {:ok, req, state}
  end

  def get_request("POST", param, req) do
    headers = [{"content-type", "application/json"}]
    {:ok, resp} = :cowboy_req.reply(200, headers, param, req)
  end

  def terminate(_reason, _req, _state) do
    IO.puts "terminate"
    :ok
  end
end

