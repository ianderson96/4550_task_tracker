defmodule TasktrackerWeb.ListItemController do
  use TasktrackerWeb, :controller

  alias Tasktracker.TaskLists
  alias Tasktracker.TaskLists.ListItem

  def index(conn, _params) do
    list_items = TaskLists.list_list_items()
    render(conn, "index.html", list_items: list_items)
  end

  def new(conn, _params) do
    changeset = TaskLists.change_list_item(%ListItem{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"list_item" => list_item_params}) do
    case TaskLists.create_list_item(list_item_params) do
      {:ok, list_item} ->
        conn
        |> put_flash(:info, "List item created successfully.")
        |> redirect(to: Routes.list_item_path(conn, :show, list_item))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    list_item = TaskLists.get_list_item!(id)
    render(conn, "show.html", list_item: list_item)
  end

  def edit(conn, %{"id" => id}) do
    list_item = TaskLists.get_list_item!(id)
    changeset = TaskLists.change_list_item(list_item)
    render(conn, "edit.html", list_item: list_item, changeset: changeset)
  end

  def update(conn, %{"id" => id, "list_item" => list_item_params}) do
    list_item = TaskLists.get_list_item!(id)

    case TaskLists.update_list_item(list_item, list_item_params) do
      {:ok, list_item} ->
        conn
        |> put_flash(:info, "List item updated successfully.")
        |> redirect(to: Routes.list_item_path(conn, :show, list_item))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", list_item: list_item, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    list_item = TaskLists.get_list_item!(id)
    {:ok, _list_item} = TaskLists.delete_list_item(list_item)

    conn
    |> put_flash(:info, "List item deleted successfully.")
    |> redirect(to: Routes.list_item_path(conn, :index))
  end
end
