defmodule WhiteBreadContext do
  use WhiteBread.Context
  use Hound.Helpers

  alias Exam.{Repo}

  feature_starting_state fn ->
    Application.ensure_all_started(:hound)
    %{}
  end

  scenario_starting_state fn _state ->
    Hound.start_session
    Ecto.Adapters.SQL.Sandbox.checkout(Exam.Repo)
    Ecto.Adapters.SQL.Sandbox.mode(Exam.Repo, {:shared, self()})
    %{}
  end

  scenario_finalize fn _status, _state ->
    Ecto.Adapters.SQL.Sandbox.checkin(Exam.Repo)
    Hound.end_session
  end

end
