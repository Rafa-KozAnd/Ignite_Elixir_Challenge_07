defmodule ApiconsumerWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :apiconsumer

  alias ApiconsumerWeb.Plugs.RefreshToken

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
  plug RefreshToken
end
