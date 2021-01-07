defmodule SecondExam.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :username, :string
    has_many :frames, SecondExam.Frame
    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:username])
    |> validate_required([:username])
    |> unique_constraint(:username, name: :games_username_index)
  end
end
