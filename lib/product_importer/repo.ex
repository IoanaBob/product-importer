defmodule ProductImporter.Repo do
  use Ecto.Repo,
    otp_app: :product_importer,
    adapter: Ecto.Adapters.Postgres
end
