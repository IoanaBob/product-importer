Code.require_file("spec/espec_phoenix_extend.ex")

{:ok, _} = Application.ensure_all_started(:ex_machina)
HTTPoison.start()

Ecto.Adapters.SQL.Sandbox.mode(ProductImporter.Repo, {:shared, self()})
