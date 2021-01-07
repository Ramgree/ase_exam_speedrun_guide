defmodule WhiteBreadContext do
  use WhiteBread.Context
  use Hound.Helpers

  alias SecondExam.{Repo}

  feature_starting_state fn ->
    Application.ensure_all_started(:hound)
    %{}
  end

  scenario_starting_state fn _state ->
    Hound.start_session
    Ecto.Adapters.SQL.Sandbox.checkout(SecondExam.Repo)
    Ecto.Adapters.SQL.Sandbox.mode(SecondExam.Repo, {:shared, self()})
    %{}
  end

  scenario_finalize fn _status, _state ->
    Ecto.Adapters.SQL.Sandbox.checkin(SecondExam.Repo)
    Hound.end_session
  end

  given_ ~r/^that my username is "(?<username>[^"]+)" and I want to play Bowling$/,
    fn state, %{username: username} ->
      {:ok, state |> Map.put(:username, username)}
  end

  then_ ~r/^I go to the start page$/, fn state ->

    navigate_to "/games/start"
    {:ok, state}
  end

  and_ ~r/^input my username$/, fn state ->

    :timer.sleep(250)

    username_input_element = find_element :id, "username"

    submit_button_element = find_element :id, "Submit"

    input_into_field username_input_element, state.username

    click submit_button_element

    :timer.sleep(250)

    {:ok, state}

  end

  and_ ~r/^I play ten games$/, fn state ->

    for n <- 1..10 do

      roll_one_input_element = find_element :id, "roll_one"
      roll_two_input_element = find_element :id, "roll_two"
      roll_three_input_element = find_element :id, "roll_three"

      :timer.sleep(250)

      fill_field roll_one_input_element, 4
      fill_field roll_two_input_element, 5
      fill_field roll_three_input_element, 0

      :timer.sleep(250)

      submit_button_element = find_element :id, "Submit"

      click submit_button_element

      :timer.sleep(250)

    end

    {:ok, state}
  end

  then_ ~r/^when I finish I should see my score$/, fn state ->

    assert visible_in_page? ~r/total score: 90/

    {:ok, state}
  end

end
