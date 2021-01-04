defmodule WhiteBreadContext do
  use WhiteBread.Context
  use Hound.Helpers

  alias BaseProject.{Repo}

  feature starting_state fn ->
    Application.ensure_all_started(:hound)
    %{}
  end

  scenario_starting_state fn _state ->
    Hound.start_session
    Ecto.Adapters.SQL.Sandbox.checkout(BaseProject.Repo)
    Ecto.Adapters.SQL.Sandbox.mode(ParkingProject.Repo, {:shared, self()})
    %{}
  end

  scenario_finalize fn _status, _state ->
    Ecto.Adapters.SQL.Sandbox.checkin(ParkingProject.Repo)
    Hound.end_session
  end



end
