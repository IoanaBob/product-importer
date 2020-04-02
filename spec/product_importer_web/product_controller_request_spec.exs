defmodule ProductImporterWeb.ProductControllerRequestSpec do
  use ESpec.Phoenix, controller: true
  alias ProductImporter.Commerce
  import ProductImporter.Factory

  describe "POST /api/products/import" do
    subject(
      build_conn()
      |> put_req_header("content-type", "multipart/form-data")
      |> put_req_header("charset", "UTF-8")
      |> post("/api/products/import", csv_data())
      |> Map.get(:resp_body)
      |> Poison.decode!()
    )

    let :csv_data do
      [
        {"PART_NUMBER|BRANCH_ID|PART_PRICE|SHORT_DESC", ""},
        {"#{product().part_number}|#{product().branch_identifier}|#{product().part_price}.0|#{
           product().short_description
         }", ""}
      ]
    end

    let(:product, do: build(:product))

    context "success" do
      let(:first_upload, do: subject() |> Map.get("data") |> Enum.at(0))
      it(do: expect(first_upload()) |> to(have({"part_price", product().part_price * 100})))

      it(
        do: expect(first_upload()) |> to(have({"short_description", product().short_description}))
      )
    end
  end
end
