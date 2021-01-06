defmodule WhiteBreadContext do
  use WhiteBread.Context
  use Hound.Helpers

  alias FirstExam.{Repo}

  feature_starting_state fn ->
    Application.ensure_all_started(:hound)
    %{}
  end

  scenario_starting_state fn _state ->
    Hound.start_session
    Ecto.Adapters.SQL.Sandbox.checkout(FirstExam.Repo)
    Ecto.Adapters.SQL.Sandbox.mode(FirstExam.Repo, {:shared, self()})
    %{}
  end

  scenario_finalize fn _status, _state ->
    Ecto.Adapters.SQL.Sandbox.checkin(FirstExam.Repo)
    Hound.end_session
  end

  given_ ~r/^that I love "(?<haskell>[^"]+)"$/,
    fn state, %{haskell: haskell} ->
      {:ok, state |> Map.put(:product_name, haskell)}
  end

  and_ ~r/^I go to the ratings list$/,
    fn state ->
      navigate_to "/ratings"
      assert visible_in_page? ~r/List of Products/
      {:ok, state}
  end

  then_ ~r/^I can see what other people rated it$/,
    fn state ->
      assert visible_in_page? ~r/0.0/
      {:ok, state}
  end

  then_ ~r/^I click "(?<rate_haskell_button>[^"]+)"$/,
    fn state, %{rate_haskell_button: rate_haskell_button} ->
      haskell_rate_button_element = find_element :id, rate_haskell_button
      click haskell_rate_button_element
      {:ok, state}
  end

  and_ ~r/^I write my email "(?<email>[^"]+)" and rating "(?<rating>[^"]+)"$/,
    fn state, %{email: email, rating: rating} ->

      email_input_element = find_element :id, "email"

      rating_input_element = find_element :id, "rating"

      submit_button_element = find_element :id, "Submit"

      :timer.sleep 500

      input_into_field email_input_element, email

      :timer.sleep 500

      input_into_field rating_input_element, rating

      click submit_button_element

      {:ok, state}
  end

  then_ ~r/^I should get a confirmation message$/, fn state ->

    assert visible_in_page? ~r/Yeehelow/

    {:ok, state}
  end

end
