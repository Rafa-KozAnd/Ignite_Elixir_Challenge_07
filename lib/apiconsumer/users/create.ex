defmodule Apiconsumer.Users.Create do
  alias Apiconsumer.{Error, Repo}
  alias Apiconsumer.Users.Schemas.User

  def call(params) do
    params
    |> User.changeset_create()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %User{} = user}), do: {:ok, user}

  defp handle_insert({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
