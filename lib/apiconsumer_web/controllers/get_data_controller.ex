defmodule ApiconsumerWeb.GetDataController do
  use ApiconsumerWeb, :controller

  alias Apiconsumer.GitHub.Input
  alias Ecto.Changeset

  alias ApiconsumerWeb.FallbackController

  action_fallback FallbackController

  def show(conn, params) do
    with {:ok, %Changeset{changes: %{user: user}}} <-
           Input.build_changeset(params),
         {:ok, [_ | _] = repos} <- client().get_repos(user) do
      conn
      |> put_status(:ok)
      |> put_resp_header("content-type", "application/json")
      |> send_resp(:ok, Jason.encode!(repos))
    end
  end

  defp client do
    Application.fetch_env!(:apiconsumer, __MODULE__)[:get_repos_adapter]
  end
end
