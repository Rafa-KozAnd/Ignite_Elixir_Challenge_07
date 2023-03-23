defmodule ApiconsumerWeb.UsersView do
  use ApiconsumerWeb, :view

  def render("create.json", %{user_id: user_id}) do
    %{
      message: "User created!",
      user_id: user_id
    }
  end

  def render("sing_in.json", %{token: token}), do: %{token: token}

  # def render("user.json", %{user: %User{} = user}), do: %{user: user}
end
