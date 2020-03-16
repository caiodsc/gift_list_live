defmodule GiftList.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :description, :text
      add :image_url, :string
      add :price, :float

      timestamps()
    end

  end
end
