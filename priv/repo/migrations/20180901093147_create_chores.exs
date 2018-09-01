defmodule Radch.Repo.Migrations.CreateChores do
  use Ecto.Migration

  def change do
    create table(:chores) do
      add(:note, :string)
      add(:period, :tsrange)

      timestamps(default: fragment("NOW()"))
    end
  end
end
