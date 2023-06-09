defmodule ApiconsumerWeb.Auth.Guardian do
  use Guardian, otp_app: :apiconsumer

  alias Apiconsumer.Error
  alias Apiconsumer.Users.Get, as: UserGet
  alias Apiconsumer.Users.Schemas.User

  def subject_for_token(%User{id: id}, _claims), do: {:ok, id}

  def resource_from_claims(%{"sub" => id}), do: UserGet.by_id(id)

  def authenticate(%{"id" => id, "password" => password}) do
    with {:ok, %User{password_hash: hash} = user} <- UserGet.by_id(id),
         true <- Pbkdf2.verify_pass(password, hash),
         {:ok, token, _claims} <-
           encode_and_sign(user, %{some: "claim"}, token_type: "refresh", ttl: {1, :minute}) do
      {:ok, token}
    else
      false -> {:error, Error.build(:unauthorized, "Please verify your credentials")}
      error -> error
    end
  end

  def authenticate(_), do: {:error, Error.build(:bad_request, "Invalid or missing params")}
end
