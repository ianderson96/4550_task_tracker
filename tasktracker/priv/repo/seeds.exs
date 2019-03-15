# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Tasktracker.Repo.insert!(%Tasktracker.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Tasktracker.Repo
alias Tasktracker.Users.User
alias Tasktracker.Tasks.Task

Repo.insert!(%User{email: "alice@example.com", admin: true, manager?: false})
Repo.insert!(%User{email: "bob@example.com", admin: false, manager?: true})
Repo.insert!(%User{email: "testuser3@gmail.com", admin: false, manager?: false})
Repo.insert!(%User{email: "testuser4@gmail.com", admin: true, manager?: true})
Repo.insert!(%Task{title: "Test task", desc: "Seeded task for testing", completed: false})
