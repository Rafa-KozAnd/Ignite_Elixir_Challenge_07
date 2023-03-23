defmodule ApiconsumerWeb.UsersControllerTest do
  use ApiconsumerWeb.ConnCase, async: true

  alias Apiconsumer.Users.Create

  describe "create/1" do
    test "sucess, when params is valid", %{conn: conn} do
      params = %{"password" => "123123"}

      response =
        conn
        |> post("/api/users", params)
        |> json_response(:created)

      assert %{
               "message" => "User created!",
               "user_id" => _id
             } = response
    end

    test "fail, when params is invalid", %{conn: conn} do
      params = %{"password" => "1231"}

      response =
        conn
        |> post("/api/users", params)
        |> json_response(:bad_request)

      assert %{
               "message" => %{"password" => ["should be at least 6 character(s)"]}
             } = response
    end
  end

  describe "sing_in/1" do
    test "sucess, when params is valid", %{conn: conn} do
      {:ok, user} = Create.call(%{"password" => "123123"})

      params = %{"id" => user.id, "password" => "123123"}

      response =
        conn
        |> post("/api/users/singin", params)
        |> json_response(:ok)

      assert %{
               "token" => _token
             } = response
    end

    test "fail, when params is invalid", %{conn: conn} do
      {:ok, user} = Create.call(%{"password" => "123123"})

      params = %{"id" => user.id, "password" => "121212"}

      response =
        conn
        |> post("/api/users/singin", params)
        |> json_response(:unauthorized)

      assert %{
               "message" => "Please verify your credentials"
             } = response
    end
  end
end
