defmodule Tasktracker.TaskListsTest do
  use Tasktracker.DataCase

  alias Tasktracker.TaskLists

  describe "list_items" do
    alias Tasktracker.TaskLists.ListItem

    @valid_attrs %{count: 42}
    @update_attrs %{count: 43}
    @invalid_attrs %{count: nil}

    def list_item_fixture(attrs \\ %{}) do
      {:ok, list_item} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TaskLists.create_list_item()

      list_item
    end

    test "list_list_items/0 returns all list_items" do
      list_item = list_item_fixture()
      assert TaskLists.list_list_items() == [list_item]
    end

    test "get_list_item!/1 returns the list_item with given id" do
      list_item = list_item_fixture()
      assert TaskLists.get_list_item!(list_item.id) == list_item
    end

    test "create_list_item/1 with valid data creates a list_item" do
      assert {:ok, %ListItem{} = list_item} = TaskLists.create_list_item(@valid_attrs)
      assert list_item.count == 42
    end

    test "create_list_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TaskLists.create_list_item(@invalid_attrs)
    end

    test "update_list_item/2 with valid data updates the list_item" do
      list_item = list_item_fixture()
      assert {:ok, %ListItem{} = list_item} = TaskLists.update_list_item(list_item, @update_attrs)
      assert list_item.count == 43
    end

    test "update_list_item/2 with invalid data returns error changeset" do
      list_item = list_item_fixture()
      assert {:error, %Ecto.Changeset{}} = TaskLists.update_list_item(list_item, @invalid_attrs)
      assert list_item == TaskLists.get_list_item!(list_item.id)
    end

    test "delete_list_item/1 deletes the list_item" do
      list_item = list_item_fixture()
      assert {:ok, %ListItem{}} = TaskLists.delete_list_item(list_item)
      assert_raise Ecto.NoResultsError, fn -> TaskLists.get_list_item!(list_item.id) end
    end

    test "change_list_item/1 returns a list_item changeset" do
      list_item = list_item_fixture()
      assert %Ecto.Changeset{} = TaskLists.change_list_item(list_item)
    end
  end
end
