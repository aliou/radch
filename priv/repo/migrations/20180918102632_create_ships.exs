defmodule Radch.Repo.Migrations.CreateShips do
  use Ecto.Migration

  def change do
    create table(:ships, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:name, :string, null: false)
      add(:ship_class, :string, null: false)

      timestamps()
    end

    create(unique_index("ships", ["name"]))
  end
end
