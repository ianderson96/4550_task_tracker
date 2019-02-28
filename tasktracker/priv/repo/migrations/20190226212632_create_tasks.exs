defmodule Tasktracker.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string
      add :desc, :text, null: false
      add :minutes, :integer
      add :completed, :boolean, null: false

      timestamps()
    end
  end
end
