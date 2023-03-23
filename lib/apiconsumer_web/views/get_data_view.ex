defmodule ApiconsumerWeb.GetDataView do
  use ApiconsumerWeb, :view

  def render("repos.json", repos) do
    %{
      message: "User created!",
      repos: repos
    }
  end
end
