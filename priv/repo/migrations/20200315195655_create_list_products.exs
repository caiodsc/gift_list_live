defmodule GiftList.Repo.Migrations.CreateListProducts do
  use Ecto.Migration

  def change do
    create table(:list_products) do
      add :quantity, :integer
      add :list_id, references(:lists, on_delete: :nothing)
      add :product_id, references(:products, on_delete: :nothing)

      timestamps()
    end

    create index(:list_products, [:list_id])
    create index(:list_products, [:product_id])
  end
end
