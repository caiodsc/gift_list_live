defmodule GiftList.GiftLists.Product do
  use Ecto.Schema
  import Ecto.Changeset

  alias GiftList.GiftLists.ListProduct

  schema "products" do
    field :description, :string
    field :image_url, :string
    field :name, :string
    field :price, :float

    has_many :list_products, ListProduct

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :description, :image_url, :price])
    |> validate_required([:name, :description, :image_url, :price])
  end
end
