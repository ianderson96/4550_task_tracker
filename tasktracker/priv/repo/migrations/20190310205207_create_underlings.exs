defmodule Tasktracker.Repo.Migrations.CreateUnderlings do
  use Ecto.Migration

  def change do
    create table(:underlings) do
      add :manager_id, references(:users, on_delete: :delete_all), null: false
      add :underling_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:underlings, [:manager_id])
    create index(:underlings, [:underling_id])
  end
end
