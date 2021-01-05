defmodule FirstExam.Repo do
  use Ecto.Repo,
    otp_app: :first_exam,
    adapter: Ecto.Adapters.Postgres
end
