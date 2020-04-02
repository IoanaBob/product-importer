defmodule ProductImporterWeb.ProductView do
  use ProductImporterWeb, :view
  alias ProductImporterWeb.ProductView

  def render("index.json", %{products: products}) do
    %{data: render_many(products, ProductView, "product.json")}
  end

  def render("product.json", %{product: product}) do
    %{
      id: product.id,
      part_number: product.part_number,
      branch_identifier: product.branch_identifier,
      part_price: product.part_price,
      short_description: product.short_description
    }
  end
end
