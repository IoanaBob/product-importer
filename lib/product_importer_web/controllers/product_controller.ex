defmodule ProductImporterWeb.ProductController do
  use ProductImporterWeb, :controller

  alias ProductImporter.Commerce

  action_fallback(ProductImporterWeb.FallbackController)

  def import(%{body_params: csv_rows} = conn, _params) do
    with products <- csv_rows |> Commerce.Product.from_csv() |> Commerce.upload_products() do
      conn
      |> put_status(:created)
      |> render("index.json", products: products)
    end
  end
end
