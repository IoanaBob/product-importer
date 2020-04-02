defmodule ESpec.Phoenix.Extend do
  def model do
    quote do
      alias ProductImporter.Repo
    end
  end

  def controller do
    quote do
      alias ProductImporter
      import ProductImporterWeb.Router.Helpers

      @endpoint ProductImporterWeb.Endpoint
    end
  end

  def view do
    quote do
      import ProductImporterWeb.Router.Helpers
    end
  end

  def channel do
    quote do
      alias ProductImporter.Repo

      @endpoint ProductImporterWeb.Endpoint
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
