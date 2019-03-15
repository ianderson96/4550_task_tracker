defmodule Tasktracker.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :admin, :boolean, default: false, null: false
      add :manager?, :boolean, default: false, null: false
      add :manager, references(:users, on_delete: :nothing), null: true

      timestamps()
    end
  end
end
