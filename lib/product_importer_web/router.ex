defmodule ProductImporterWeb.Router do
  use ProductImporterWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api", ProductImporterWeb do
    pipe_through(:api)

    post("/products/import", ProductController, :import)
  end
end
