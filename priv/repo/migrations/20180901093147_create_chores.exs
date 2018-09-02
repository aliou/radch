defmodule Radch.Repo.Migrations.CreateChores do
  use Ecto.Migration

  def up do
    execute("CREATE EXTENSION btree_gist")

    create table(:chores) do
      add(:user_id, references("users", on_delete: :delete_all), null: false)
      add(:note, :string)
      add(:period, :tsrange)

      timestamps(default: fragment("NOW()"))
    end

    create(
      constraint(
        "chores",
        :no_overlaping_chores_for_user,
        exclude: ~s|gist (user_id with =, period with &&)|
      )
    )
  end

  def down do
    drop(constraint("chores", :no_overlaping_chores_for_user))
    drop(table(:chores))
    execute("DROP EXTENSION btree_gist")
  end
end
