defmodule GiftList.GiftLists.List do
  use Ecto.Schema
  import Ecto.Changeset

  alias GiftList.GiftLists.ListProduct
  alias GiftList.GiftLists.Product

  schema "lists" do
    field :products_count, :integer, default: 0
    field :session, :string
    field :total, :float, default: 0.0

    has_many :list_products, ListProduct
    has_many :products, through: [:list_products, :product]

    timestamps()
  end

  @doc false
  def changeset(list, attrs) do
    list
    |> cast(attrs, [:session, :products_count, :total])
    |> validate_required([:session])
  end
end
