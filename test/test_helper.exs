{:ok, _} = Application.ensure_all_started(:ex_machina)
{:ok, _} = VirtualFieldsFiller.Repo.start_link()

ExUnit.start()

Ecto.Adapters.SQL.Sandbox.mode(VirtualFieldsFiller.Repo, :manual)
