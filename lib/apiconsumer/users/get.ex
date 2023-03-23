defmodule Apiconsumer.Users.Get do
  alias Apiconsumer.{Error, Repo}
  alias Apiconsumer.Users.Schemas.User

  def by_id(id) do
    case Repo.get(User, id) do
      %User{} = user -> {:ok, user}
      nil -> {:error, Error.build(:bad_request, "User not found")}
    end
  end
end
