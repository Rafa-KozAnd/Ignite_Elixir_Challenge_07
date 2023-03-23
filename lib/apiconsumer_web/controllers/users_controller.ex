defmodule ApiconsumerWeb.UsersController do
  use ApiconsumerWeb, :controller

  alias Apiconsumer
  alias Ecto.Changeset
  alias Apiconsumer.Users.Schemas.User
  alias ApiconsumerWeb.FallbackController
  alias ApiconsumerWeb.Auth.Guardian

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %User{id: user_id}} <- Apiconsumer.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user_id: user_id)
    end
  end

  def sing_in(conn, params) do
    with %Changeset{valid?: true} <- User.changeset_create(params),
         {:ok, token} <- Guardian.authenticate(params) do
      conn
      |> put_status(:ok)
      |> render("sing_in.json", token: token)
    end
  end
end
