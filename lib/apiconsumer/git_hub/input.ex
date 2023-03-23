defmodule Apiconsumer.GitHub.Input do
  use Ecto.Schema
  import Ecto.Changeset
  alias Apiconsumer.Error

  @required_params [:user]

  embedded_schema do
    field :user, :string
  end

  def build_changeset(params) do
    case changeset(params) do
      %Ecto.Changeset{valid?: true} = changeset -> {:ok, changeset}
      %Ecto.Changeset{valid?: false} = changeset -> Error.build(:bad_request, changeset)
    end
  end

  defp changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:user, min: 4)
  end
end
