defmodule BaseProject.Repo do
  use Ecto.Repo,
    otp_app: :base_project,
    adapter: Ecto.Adapters.Postgres
end
