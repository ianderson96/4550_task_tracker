defmodule Tasktracker.Repo.Migrations.CreateListItems do
  use Ecto.Migration

  def change do
    create table(:list_items) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :task_id, references(:tasks, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:list_items, [:user_id, :task_id], unique: true)
  end
end
