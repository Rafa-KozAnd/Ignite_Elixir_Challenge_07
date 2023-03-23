defmodule Apiconsumer.Users.Schemas.User do
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:password]

  @derive {Jason.Encoder, only: [:id]}

  schema "users" do
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  def validate_inputs(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:password, min: 6)
  end

  def changeset_create(params) do
    params
    |> changeset(@required_params)
  end

  defp changeset(struct \\ %__MODULE__{}, params, fields) do
    struct
    |> cast(params, fields)
    |> validate_required(fields)
    |> validate_length(:password, min: 6)
    |> put_password_hash()
  end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(changeset, Pbkdf2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
