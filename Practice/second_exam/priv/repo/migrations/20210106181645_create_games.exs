defmodule SecondExam.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :username, :string

      timestamps()
    end
    create unique_index(:games, [:username], name: :games_username_index)
  end
end
