defmodule WebsocketsListener.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  @content_type "application/json"

  get "/status" do
    conn
    |> put_resp_content_type(@content_type)
    |> send_resp(200, "RUNNING")
  end

  match _ do
    conn
    |> put_resp_content_type(@content_type)
    |> send_resp(404, "Requested page not found!")
  end
end

# iex --cookie secret --name local@wsl:4000 \
#     -e "Node.connect(:'remote@wsl:4000')" \
#     -S mix run --no-start

