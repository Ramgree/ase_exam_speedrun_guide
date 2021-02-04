defmodule Exam.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :pin, :integer
      add :balance, :float

      timestamps()
    end
    create unique_index(:users, [:email], name: :users_email_index)
  end
end
