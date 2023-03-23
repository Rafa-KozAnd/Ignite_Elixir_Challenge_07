defmodule Apiconsumer.GitHub.Client do
  use Tesla
  alias Apiconsumer.Error
  alias Tesla.Env

  @behaviour Apiconsumer.GitHub.Behaviour

  @base_url "https://api.github.com/users/"
  plug Tesla.Middleware.JSON
  plug Tesla.Middleware.Headers, [{"user-agent", "Tesla"}]

  def get_repos(url \\ @base_url, user_name) do
    "#{url}#{user_name}/repos"
    |> get()
    |> handle_get()
  end

  defp handle_get({:ok, %Env{status: 404, body: %{"message" => "Not Found"}}}) do
    {:error, Error.build(:not_found, "user not found!")}
  end

  defp handle_get({:error, reason}) do
    {:error, Error.build(:bad_request, reason)}
  end

  defp handle_get({:ok, %Env{status: 200, body: body}}) do
    response =
      Enum.map(body, fn repo ->
        %{
          id: repo["id"],
          name: repo["name"],
          description: repo["description"],
          html_url: repo["html_url"],
          stargazers_count: repo["stargazers_count"]
        }
      end)

    {:ok, response}
  end
end
