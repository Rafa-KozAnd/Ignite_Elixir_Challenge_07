defmodule Apiconsumer.GitHub.InputTest do
  use ExUnit.Case
  alias Apiconsumer.GitHub.Input

  describe "build_changeset/1" do
    test "sucess, when params are valid" do
      params = %{"user" => "bruguedes"}
      response = Input.build_changeset(params)

      assert {
               :ok,
               %Ecto.Changeset{
                 changes: %{user: "bruguedes"},
                 errors: [],
                 valid?: true
               }
             } = response
    end

    test "fail, when params is not string" do
      params = %{"user" => 12345}
      response = Input.build_changeset(params)

      assert %Apiconsumer.Error{
               result: %Ecto.Changeset{
                 errors: [user: {"is invalid", [type: :string, validation: :cast]}],
                 valid?: false
               },
               status: :bad_request
             } = response
    end

    test "fail, when params are invalid" do
      params = %{"user" => "bru"}
      response = Input.build_changeset(params)

      assert %Apiconsumer.Error{
               result: %Ecto.Changeset{
                 changes: %{user: "bru"},
                 errors: [
                   user:
                     {"should be at least %{count} character(s)",
                      [count: 4, validation: :length, kind: :min, type: :string]}
                 ],
                 valid?: false
               },
               status: :bad_request
             } = response
    end
  end
end
