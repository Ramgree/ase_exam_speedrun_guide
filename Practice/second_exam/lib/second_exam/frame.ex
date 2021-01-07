defmodule SecondExam.Frame do
  use Ecto.Schema
  import Ecto.Changeset

  schema "frames" do
    field :current, :integer
    field :roll_one, :integer, default: 0
    field :roll_two, :integer, default: 0
    field :roll_three, :integer
    field :score, :integer, default: 0
    belongs_to :game, SecondExam.Game
    timestamps()
  end

  @doc false
  def changeset(frame, attrs) do
    frame
    |> cast(attrs, [:roll_one, :roll_two, :roll_three, :current, :score, :game_id])
    |> validate_required([:roll_one, :roll_two, :roll_three, :current, :score, :game_id])
    |> validate_number(:roll_one, greater_than_or_equal_to: 0, less_than_or_equal_to: 10)
    |> validate_number(:roll_two, greater_than_or_equal_to: 0, less_than_or_equal_to: 10)
    |> validate_number(:roll_three, greater_than_or_equal_to: 0, less_than_or_equal_to: 10)
    |> validate_number(:current, greater_than_or_equal_to: 1, less_than_or_equal_to: 10)
    |> validate_sum_roll_one_roll_two
    |> validate_roll_three
  end

  def validate_roll_three(changeset) do
    current = get_field(changeset, :current)
    roll_one = get_field(changeset, :roll_one)
    roll_two = get_field(changeset, :roll_two)
    roll_three = get_field(changeset, :roll_three)

    case roll_three > 0 do
      true ->
        case current < 10 do
          true ->
            add_error(changeset, :roll_three, "roll 3 cannot be bigger than 0 in this frame")
          _ ->
            case (roll_one + roll_two == 10) do
              true ->
                changeset
              false ->
                add_error(changeset, :roll_three, "strike and spare are needed")
            end
        end
      _ ->
        changeset
    end
  end

  def validate_sum_roll_one_roll_two(changeset) do
    roll_one = get_field(changeset, :roll_one)
    roll_two = get_field(changeset, :roll_two)
    current = get_field(changeset, :current)

    case (current < 10) do

      true ->

        case (roll_one + roll_two) > 10 do
          true ->
            add_error(changeset, :roll_one, "roll 1 + roll 2 can't be bigger than 10")
          _ ->
            changeset
        end

      false ->

        changeset

    end

  end

end
