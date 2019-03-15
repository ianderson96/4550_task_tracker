defmodule TasktrackerWeb.UnderlingController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Underlings
  alias Tasktracker.Underlings.Underling

  def index(conn, _params) do
    underlings = Underlings.list_underlings()
    render(conn, "index.html", underlings: underlings)
  end

  def new(conn, _params) do
    changeset = Underlings.change_underling(%Underling{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"underling" => underling_params}) do
    case Underlings.create_underling(underling_params) do
      {:ok, underling} ->
        conn
        |> put_flash(:info, "Underling created successfully.")
        |> redirect(to: Routes.underling_path(conn, :show, underling))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    underling = Underlings.get_underling!(id)
    render(conn, "show.html", underling: underling)
  end

  def edit(conn, %{"id" => id}) do
    underling = Underlings.get_underling!(id)
    changeset = Underlings.change_underling(underling)
    render(conn, "edit.html", underling: underling, changeset: changeset)
  end

  def update(conn, %{"id" => id, "underling" => underling_params}) do
    underling = Underlings.get_underling!(id)

    case Underlings.update_underling(underling, underling_params) do
      {:ok, underling} ->
        conn
        |> put_flash(:info, "Underling updated successfully.")
        |> redirect(to: Routes.underling_path(conn, :show, underling))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", underling: underling, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    underling = Underlings.get_underling!(id)
    {:ok, _underling} = Underlings.delete_underling(underling)

    conn
    |> put_flash(:info, "Underling deleted successfully.")
    |> redirect(to: Routes.underling_path(conn, :index))
  end
end
