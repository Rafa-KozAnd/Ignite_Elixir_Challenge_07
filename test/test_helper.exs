ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Apiconsumer.Repo, :manual)

Mox.defmock(Apiconsumer.GitHub.ClientMock, for: Apiconsumer.GitHub.Behaviour)
