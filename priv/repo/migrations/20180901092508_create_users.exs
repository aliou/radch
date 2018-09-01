defmodule Radch.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:name, :string)

      timestamps(default: fragment("now()"))
    end
  end
end
