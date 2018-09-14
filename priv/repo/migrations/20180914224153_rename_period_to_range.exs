defmodule Radch.Repo.Migrations.RenamePeriodToRange do
  use Ecto.Migration

  def change do
    rename(table("chores"), :period, to: :range)

    alter table("chores") do
      modify(:range, :tsrange, null: false)
    end
  end
end
