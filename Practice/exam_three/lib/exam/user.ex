defmodule Exam.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :balance, :float
    field :email, :string
    field :pin, :integer

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :pin, :balance])
    |> validate_required([:email, :pin, :balance])
    |> unique_constraint(:email, name: :users_email_index)
    |> validate_number(:balance, greater_than_or_equal_to: 0.0)
    |> validate_format(:email, ~r/@/)
  end
end
