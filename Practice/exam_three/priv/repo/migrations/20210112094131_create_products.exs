defmodule Exam.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :unit, :float
      add :quantity, :integer

      timestamps()
    end
    create unique_index(:products, [:name], name: :products_name_index)
  end
end
