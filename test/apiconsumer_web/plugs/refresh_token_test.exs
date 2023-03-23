defmodule ApiconsumerWeb.Plugs.RefreshTokenTest do
  use ApiconsumerWeb.ConnCase, async: true

  alias Apiconsumer.Users.Create
  alias ApiconsumerWeb.Auth.Guardian
  alias ApiconsumerWeb.Plugs.RefreshToken

  describe "show/1" do
    setup do
      {:ok, user} = Create.call(%{"password" => "123456"})
      {:ok, token, _claims} = Guardian.encode_and_sign(user)

      {:ok, token: token}
    end

    test "sucess, when token is valid", %{conn: conn, token: token} do
      conn = put_req_header(conn, "authorization", "Bearer #{token}")
      ["Bearer " <> original_token] = get_req_header(conn, "authorization")

      conn_refresh_token = RefreshToken.call(conn, nil)
      ["Bearer " <> new_token] = get_req_header(conn_refresh_token, "authorization")

      valid_original_token = Guardian.decode_and_verify(original_token)
      valid_new_token = Guardian.decode_and_verify(new_token)

      assert original_token != new_token
      assert {:ok, _} = valid_original_token
      assert {:ok, _} = valid_new_token
    end

    test "fail, when token a invalid", %{conn: conn} do
      invalid_token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c"

      conn = put_req_header(conn, "authorization", "Bearer  #{invalid_token}")
      conn_refresh_token = RefreshToken.call(conn, nil)

      ["Bearer  " <> original_token] = get_req_header(conn, "authorization")

      ["Bearer  " <> new_token] = get_req_header(conn_refresh_token, "authorization")

      valid_original_token = Guardian.decode_and_verify(original_token)
      valid_new_token = Guardian.decode_and_verify(new_token)

      assert {:error, :invalid_token} = valid_original_token
      assert {:error, :invalid_token} = valid_new_token
    end
  end
end
