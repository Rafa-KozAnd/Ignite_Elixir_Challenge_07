defmodule ApiconsumerWeb.Plugs.RefreshToken do
  import Plug.Conn

  alias Plug.Conn

  alias ApiconsumerWeb.Auth.Guardian

  def init(options), do: options

  def call(%Conn{} = conn, _opts) do
    ["Bearer " <> token] = get_req_header(conn, "authorization")

    case Guardian.refresh(token, ttl: {1, :minute}) do
      {:ok, _old_stuff, {new_token, _new_claims}} ->
        conn =
          conn
          |> put_req_header("authorization", "Bearer #{new_token}")

        conn

      _rease ->
        render_error(conn)
    end
  end

  def call(conn, _opts), do: conn

  defp render_error(conn) do
    body = Jason.encode!(%{message: "Invalid token"})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(:bad_request, body)
    |> halt()
  end
end
