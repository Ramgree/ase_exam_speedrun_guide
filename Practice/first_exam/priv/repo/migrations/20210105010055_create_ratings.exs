defmodule FirstExam.Repo.Migrations.CreateRatings do
  use Ecto.Migration

  def change do
    create table(:ratings) do
      add :email, :string
      add :rating, :float
      add :product_id, references(:products)
      timestamps()
    end
    create unique_index(:ratings, :email)
  end
end
