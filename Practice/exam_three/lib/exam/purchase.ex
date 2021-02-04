defmodule Exam.Purchase do
  use Ecto.Schema
  import Ecto.Changeset

  schema "purchases" do
    field :bid, :float
    field :query, :string
    belongs_to :user, Exam.User
    belongs_to :product, Exam.Product

    timestamps()
  end

  @doc false
  def changeset(purchase, attrs) do
    purchase
    |> cast(attrs, [:query, :bid, :user_id, :product_id])
    |> validate_required([:query, :bid])
  end
end
