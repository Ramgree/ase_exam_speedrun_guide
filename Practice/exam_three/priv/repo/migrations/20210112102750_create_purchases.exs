defmodule Exam.Repo.Migrations.CreatePurchases do
  use Ecto.Migration

  def change do
    create table(:purchases) do
      add :query, :string
      add :bid, :float
      add :user_id, references(:users)
      add :product_id, references(:products)

      timestamps()
    end

  end
end
