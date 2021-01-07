defmodule SecondExam.Repo.Migrations.CreateFrames do
  use Ecto.Migration

  def change do
    create table(:frames) do
      add :roll_one, :integer
      add :roll_two, :integer
      add :roll_three, :integer
      add :current, :integer
      add :score, :integer
      add :game_id, references(:games)
      timestamps()
    end
  end
end
