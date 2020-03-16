defmodule GiftList.GiftLists.ListProduct do
  use Ecto.Schema
  import Ecto.Changeset

  alias GiftList.GiftLists.List
  alias GiftList.GiftLists.Product

  schema "list_products" do
    field :quantity, :integer, default: 0

    belongs_to :product, Product
    belongs_to :list, List

    timestamps()
  end

  @doc false
  def changeset(list_product, attrs) do
    list_product
    |> cast(attrs, [:quantity])
    |> validate_required([:quantity])
  end
end
