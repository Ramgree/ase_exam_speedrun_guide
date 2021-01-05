defmodule SecondExam.Repo do
  use Ecto.Repo,
    otp_app: :second_exam,
    adapter: Ecto.Adapters.Postgres
end
