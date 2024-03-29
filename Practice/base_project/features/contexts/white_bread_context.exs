defmodule WhiteBreadContext do
  use WhiteBread.Context
  use Hound.Helpers

  alias BaseProject.{Repo}

  feature_starting_state fn ->
    Application.ensure_all_started(:hound)
    %{}
  end

  scenario_starting_state fn _state ->
    Hound.start_session
    Ecto.Adapters.SQL.Sandbox.checkout(BaseProject.Repo)
    Ecto.Adapters.SQL.Sandbox.mode(BaseProject.Repo, {:shared, self()})
    %{}
  end

  scenario_finalize fn _status, _state ->
    Ecto.Adapters.SQL.Sandbox.checkin(BaseProject.Repo)
    Hound.end_session
  end

  given_ ~r/^that I want to go to the app$/, fn state ->
    {:ok, state}
  end

  and_ ~r/^I am on the App$/, fn state ->
    {:ok, state}
  end

  then_ ~r/^I confirm that white bread works$/, fn state ->
    {:ok, state}
  end


end
