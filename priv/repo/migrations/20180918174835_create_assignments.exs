defmodule Radch.Repo.Migrations.CreateAssignments do
  use Ecto.Migration

  def change do
    create table(:assignments) do
      add(:user_id, references(:users, on_delete: :delete_all))
      add(:ship_id, references(:ships, type: :uuid, on_delete: :delete_all))
      add(:rank, :string)

      timestamps()
    end

    create(index(:assignments, [:user_id]))
    create(index(:assignments, [:ship_id]))
    create(unique_index(:assignments, [:user_id, :ship_id]))
  end
end
