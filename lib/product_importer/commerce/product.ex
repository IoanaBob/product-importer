defmodule ProductImporter.Commerce.Product do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "products" do
    field(:branch_identifier, :string)
    field(:part_number, :string)
    field(:part_price, :integer)
    field(:short_description, :string)

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:part_number, :branch_identifier, :part_price, :short_description])
    |> unique_constraint(:part_number, message: "Part number already exists")
    |> validate_required([:part_number, :branch_identifier, :part_price, :short_description])
  end

  def from_csv(csv_rows),
    do: csv_rows |> Map.keys() |> Enum.map(&map_row_attributes(&1))

  ### PRIVATE

  defp map_row_attributes("PART_NUMBER|BRANCH_ID|PART_PRICE|SHORT_DESC" = _headers), do: %{}

  defp map_row_attributes(row) do
    attrs = String.split(row, "|")

    %{
      part_number: Enum.at(attrs, 0),
      branch_identifier: Enum.at(attrs, 1),
      part_price: attrs |> Enum.at(2) |> transform_part_price(),
      short_description: Enum.at(attrs, 3)
    }
  end

  def transform_part_price(part_price) do
    with price <- String.to_float(part_price),
         price_cents <- ceil(price * 100) do
      price_cents
    end
  end
end
