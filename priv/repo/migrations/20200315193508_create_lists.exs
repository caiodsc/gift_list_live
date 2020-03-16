defmodule GiftList.Repo.Migrations.CreateLists do
  use Ecto.Migration

  def change do
    create table(:lists) do
      add :session, :string
      add :products_count, :integer
      add :total, :float

      timestamps()
    end

  end
end
