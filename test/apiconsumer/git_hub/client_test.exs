defmodule Apiconsumer.GitHub.ClientTest do
  use ExUnit.Case, async: true

  alias Apiconsumer.Error
  alias Apiconsumer.GitHub.Client

  describe "get_repos/1" do
    setup do
      bypass = Bypass.open()

      {:ok, bypass: bypass}
    end

    test "when there is valid user name, return the repos", %{bypass: bypass} do
      body =
        ~s([{"description" : "Test success", "html_url" : "https://github.com/test/test-com-bypass","id" : 123456789,"name" : "test bypass", "stargazers_count" : 0}])

      user_name = "test"

      url = endpoint_url(bypass.port)

      Bypass.expect(bypass, "GET", "#{user_name}/repos", fn conn ->
        conn
        |> Plug.Conn.put_resp_header("content-type", "application/json")
        |> Plug.Conn.resp(200, body)
      end)

      response = Client.get_repos(url, user_name)

      expected_response =
        {:ok,
         [
           %{
             description: "Test success",
             html_url: "https://github.com/test/test-com-bypass",
             id: 123_456_789,
             name: "test bypass",
             stargazers_count: 0
           }
         ]}

      assert expected_response == response
    end

    test "when there is a invalid user name, returns an error", %{bypass: bypass} do
      user_name = "invalid_user"

      url = endpoint_url(bypass.port)

      body = ~s({"message": "Not Found"})

      Bypass.expect(bypass, "GET", "#{user_name}/repos", fn conn ->
        conn
        |> Plug.Conn.put_resp_header("content-type", "application/json")
        |> Plug.Conn.resp(404, body)
      end)

      response = Client.get_repos(url, user_name)

      expected_response = {:error, Error.build(:not_found, "user not found!")}

      assert expected_response == response
    end

    test "when timeout occurs, returns an error", %{bypass: bypass} do
      user_name = "bruguedes"

      url = endpoint_url(bypass.port)

      Bypass.down(bypass)

      response = Client.get_repos(url, user_name)

      expected_response =
        {:error, %Apiconsumer.Error{result: :econnrefused, status: :bad_request}}

      assert expected_response == response
    end

    defp endpoint_url(port), do: "http://localhost:#{port}/"
  end
end
