defmodule ProductImporter.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:part_number, :string)
      add(:branch_identifier, :string)
      add(:part_price, :integer)
      add(:short_description, :text)

      timestamps()
    end

    create(unique_index(:products, [:part_number]))
  end
end
