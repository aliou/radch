defmodule Radch.Repo do
  use Ecto.Repo, otp_app: :radch, adapter: Ecto.Adapters.Postgres

  @doc """
  Dynamically loads the repository url from the
  DATABASE_URL environment variable.
  """
  def init(_, opts) do
    opts =
      opts
      |> Keyword.put(:url, System.get_env("DATABASE_URL"))

    {:ok, opts}
  end
end
