defmodule ProductImporter.Factory do
  use ExMachina.Ecto, repo: ProductImporter.Repo
  alias ProductImporter.Commerce.Product

  def product_factory do
    %Product{
      part_number: "ASEFGD-#{:os.system_time(:millisecond)}",
      branch_identifier: "ASEFGRHN",
      part_price: 100,
      short_description: "some description"
    }
  end
end
