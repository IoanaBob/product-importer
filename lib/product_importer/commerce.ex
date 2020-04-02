defmodule ProductImporter.Commerce do
  @moduledoc """
  The Commerce context.
  """

  import Ecto.Query, warn: false
  alias ProductImporter.Repo

  alias ProductImporter.Commerce.Product

  def upload_products(attrs_list \\ [%{}]) do
    attrs_list
    |> Enum.map(&upsert_product(&1))
    |> Enum.map(fn changeset_response ->
      with {:ok, product} <- changeset_response do
        product
      else
        _ -> nil
      end
    end)
    |> Enum.reject(&is_nil/1)
  end

  def upsert_product(
        %{
          branch_identifier: branch_identifier,
          part_number: part_number,
          part_price: part_price,
          short_description: short_description
        } = attrs
      ) do
    changeset =
      %Product{}
      |> Product.changeset(attrs)
      |> Repo.insert(
        on_conflict: [
          set: [
            branch_identifier: branch_identifier,
            part_number: part_number,
            part_price: part_price,
            short_description: short_description
          ]
        ],
        conflict_target: :part_number
      )
  end

  def upsert_product(_), do: change_product(%Product{})

  def change_product(%Product{} = product) do
    Product.changeset(product, %{})
  end
end
