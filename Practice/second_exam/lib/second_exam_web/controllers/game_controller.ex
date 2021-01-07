defmodule SecondExamWeb.GameController do
  use SecondExamWeb, :controller

  import Ecto.Query, only: [from: 2]

  alias SecondExam.Repo
  alias SecondExam.{Frame, Game}
  alias Ecto.{Changeset, Multi}

  def start(conn, _params) do

    changeset = Game.changeset(%Game{}, %{})

    render conn, "start.html", game_changeset: changeset

  end

  def create(conn, %{"game" => game_params}) do

    game_changeset = Game.changeset(%Game{}, game_params)

    case Repo.insert(game_changeset) do
      {:ok, game_inserted_changeset} ->

        frame_changeset = Frame.changeset(%Frame{}, %{game_id: game_inserted_changeset.id,
                                                      current: 1})

        render conn, "play.html", changeset: frame_changeset

      {:error, changeset} ->
        conn
        |> render "start.html", game_changeset: changeset

    end

  end


  def play(conn, %{"frame" => frame_params}) do

    frame_changeset = Frame.changeset(%Frame{}, frame_params)

    case Repo.insert(frame_changeset) do
      {:ok, inserted_frame} ->

        IO.inspect inserted_frame, label: "inserthon"

        current = inserted_frame.current
        roll_one = inserted_frame.roll_one
        roll_two = inserted_frame.roll_two
        roll_three = inserted_frame.roll_three
        game_id = inserted_frame.game_id

        score = case current < 10 do
                  true -> roll_one + roll_two
                  false -> roll_one + roll_two + roll_three
                end

        Frame.changeset(inserted_frame, %{})
        |> Changeset.put_change(:score, score)
        |> Repo.update

        previous_current = current - 1

        case current > 1 do
          true ->
            previous_frame = Repo.one(Ecto.Query.from f in SecondExam.Frame,
              where: f.game_id == ^game_id and f.current == ^previous_current)
            case (previous_frame.roll_one + previous_frame.roll_two) == 10 do
              true ->
                case previous_frame.roll_one == 10 do
                  true ->
                    Frame.changeset(previous_frame, %{})
                    |> Changeset.put_change(:score, previous_frame.score + inserted_frame.roll_one + inserted_frame.roll_two)
                    |> Repo.update
                  false ->
                    Frame.changeset(previous_frame, %{})
                    |> Changeset.put_change(:score, previous_frame.score + inserted_frame.roll_one)
                    |> Repo.update
                end
              false ->
            end
          false ->
        end

      case (current + 1) > 10 do

        true ->
          total_score = Enum.sum(Repo.all(from f in Frame, where: f.game_id == ^game_id, select: f.score))

          conn
          |> put_flash(:info, "total score: #{total_score}")
          |> redirect(to: Routes.page_path(conn, :index))

        false ->
          next_frame_changeset = Frame.changeset(%Frame{}, %{game_id: inserted_frame.game_id,
                                                           current: current+1})

          conn
          |> render "play.html", changeset: next_frame_changeset

      end
      {:error, changeset} ->
        conn
        |> render "play.html", changeset: changeset
      end

  end

end
