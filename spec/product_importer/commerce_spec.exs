defmodule ProductImporter.CommerceSpec do
  use ESpec.Phoenix, model: ProductImporter.Commerce
  alias ProductImporter.Commerce
  alias ProductImporter.Commerce.Product
  import ProductImporter.Factory

  describe "products" do
    def product_count, do: Repo.all(Product) |> Enum.count()
    def last_product, do: Repo.all(Product) |> Enum.at(-1)

    describe "#upsert_product(data)" do
      subject(Commerce.upsert_product(product_params()))

      let!(:product_params, do: params_for(:product))

      context "on create" do
        subject(Commerce.upsert_product(product_params()))

        context "success" do
          it(do: is_expected() |> to(be_ok_result()))
          it(do: is_expected() |> to(eq({:ok, last_product()})))

          it "should create a product" do
            expect(&subject/0) |> to(change(&product_count/0, by: 1))
          end
        end

        context "failure" do
          context "when product has invalid :part_price parameter" do
            let!(:product_params,
              do: params_for(:product, part_price: :bad_price)
            )

            it(do: is_expected() |> to(be_error_result()))
          end
        end
      end

      context "on update" do
        subject(Commerce.upsert_product(new_params()))

        let!(:product, do: insert(:product, product_params()))
        let(:new_params, do: product_params())

        context "success" do
          it(do: is_expected() |> to(be_ok_result()))

          it "should not add a new product" do
            expect(&subject/0) |> to_not(change(&product_count/0))
          end
        end

        context "error" do
          let(:new_params, do: product_params() |> Map.put(:part_price, :bad))
          it(do: is_expected() |> to(be_error_result()))
        end
      end
    end

    describe "#change_product(product)" do
      subject(Commerce.change_product(product()))

      let!(:product, do: insert(:product))
      it(do: is_expected() |> to(be_struct(Ecto.Changeset)))
    end
  end
end
