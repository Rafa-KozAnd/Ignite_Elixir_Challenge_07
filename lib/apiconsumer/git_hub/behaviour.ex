defmodule Apiconsumer.GitHub.Behaviour do
  alias Apiconsumer.Error
  @callback get_repos(String.t()) :: {:ok, map()} | {:error, Error.t()}
end
