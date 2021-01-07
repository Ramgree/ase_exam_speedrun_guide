defmodule SecondExamWeb.Game.GameControllerTest do
  use SecondExamWeb.ConnCase

  alias SecondExam.{Repo, Game, Frame}
  alias Ecto.Changeset
  import Ecto.Query, only: [from: 2]

  test "one - one game per player / redirect to new frame", %{conn: conn} do

    new_game = %Game{}
    |> Game.changeset(%{username: "rucy@ut.ee"})
    |> Repo.insert!

    new_game_two = %Game{}
    |> Game.changeset(%{username: "rucy@ut.ee"})

    case Repo.insert(new_game_two) do

      {:error, _changeset} ->

        conn = post conn, "/games", %{game: [username: "rucy2@ut.ee"]}
        assert html_response(conn, 200) =~ ~r/Current Frame: 1/

      _ ->

    end

  end

  test "two - frame saving / sum of two pins", %{conn: conn} do

    new_game = %Game{}
    |> Game.changeset(%{username: "rukkilimamagi@ut.ee"})
    |> Repo.insert!

    frame_insert = %Frame{}
    |> Frame.changeset(%{game_id: new_game.id,
                         roll_one: 0,
                         roll_two: 5,
                         roll_three: 0,
                         current: 1,
                         score: 5
                        })

    case Repo.insert(frame_insert) do

      {:ok, strukt} ->

        frame_insert = %Frame{}
        |> Frame.changeset(%{game_id: new_game.id,
                            roll_one: 10,
                            roll_two: 5,
                            roll_three: 0,
                            current: 2,
                            score: 5
                            })

        case Repo.insert(frame_insert) do

          {:error, _chset} ->

            assert true

          _ ->

        end

      _ ->
    end

  end

  test "three - roll three restriction / spare and strike", %{conn: conn} do

     new_game = %Game{}
     |> Game.changeset(%{username: "rukkilimamagi@ut.ee"})
     |> Repo.insert!

    frame_insert = %Frame{}
    |> Frame.changeset(%{game_id: new_game.id,
                        roll_one: 4,
                        roll_two: 5,
                        roll_three: 3,
                        current: 10,
                        score: 9
                        })

    case Repo.insert(frame_insert) do

      {:error, _} ->

        inserts_with_invalid_roll_threes = 1..9 |>
          Enum.map(
            fn n -> %Frame{}
            |> Frame.changeset(%{game_id: new_game.id,
                                roll_one: 0,
                                roll_two: 0,
                                roll_three: 1,
                                current: n,
                                score: 0})
            |> Repo.insert

            end
          )

        valid_booleans = Enum.map(inserts_with_invalid_roll_threes, fn {k, v} -> v.valid? end)

        for bools <- valid_booleans,
        do: refute bools

      {:ok, _} ->

        assert false

     end



  end

  test "four - total score / redirect", %{conn: conn} do

     conn = post conn, "/games", %{game: [username: "rucy2@ut.ee"]}
     assert html_response(conn, 200) =~ ~r/Current Frame: 1/
     current_game = Repo.one!(from g in Game, where: g.username == ^"rucy2@ut.ee")

     for n <- 1..9 do

       conn = post conn, "/games/play", %{frame: [game_id: current_game.id,
                                         roll_one: n,
                                         roll_two: 10-n,
                                         roll_three: 0,
                                         current: n,
                                         score: 0]}

       assert html_response(conn, 200) =~ ~r/Current Frame: #{n+1}/

     end

     conn = post conn, "games/play", %{frame: [game_id: current_game.id,
                                         roll_one: 10,
                                         roll_two: 0,
                                         roll_three: 1,
                                         current: 10,
                                         score: 0]}

     total_score = Enum.sum(Repo.all(from f in Frame, where: f.game_id == ^current_game.id, select: f.score))

     IO.inspect total_score, label: "tot score"

     conn = get conn, redirected_to(conn)

     assert html_response(conn, 200) =~ ~r/total score: #{total_score}/

  end


end
