defmodule SchoolsApi.RootTest do
  use SchoolsApi.DataCase

  alias SchoolsApi.Root

  describe "schools" do
    alias SchoolsApi.Root.School

    @valid_attrs %{address: "some address", name: "some name", phone: "some phone"}
    @update_attrs %{address: "some updated address", name: "some updated name", phone: "some updated phone"}
    @invalid_attrs %{address: nil, name: nil, phone: nil}

    def school_fixture(attrs \\ %{}) do
      {:ok, school} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Root.create_school()

      school
    end

    test "list_schools/0 returns all schools" do
      school = school_fixture()
      assert Root.list_schools() == [school]
    end

    test "get_school!/1 returns the school with given id" do
      school = school_fixture()
      assert Root.get_school!(school.id) == school
    end

    test "create_school/1 with valid data creates a school" do
      assert {:ok, %School{} = school} = Root.create_school(@valid_attrs)
      assert school.address == "some address"
      assert school.name == "some name"
      assert school.phone == "some phone"
    end

    test "create_school/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Root.create_school(@invalid_attrs)
    end

    test "update_school/2 with valid data updates the school" do
      school = school_fixture()
      assert {:ok, %School{} = school} = Root.update_school(school, @update_attrs)
      assert school.address == "some updated address"
      assert school.name == "some updated name"
      assert school.phone == "some updated phone"
    end

    test "update_school/2 with invalid data returns error changeset" do
      school = school_fixture()
      assert {:error, %Ecto.Changeset{}} = Root.update_school(school, @invalid_attrs)
      assert school == Root.get_school!(school.id)
    end

    test "delete_school/1 deletes the school" do
      school = school_fixture()
      assert {:ok, %School{}} = Root.delete_school(school)
      assert_raise Ecto.NoResultsError, fn -> Root.get_school!(school.id) end
    end

    test "change_school/1 returns a school changeset" do
      school = school_fixture()
      assert %Ecto.Changeset{} = Root.change_school(school)
    end
  end

  describe "users" do
    alias SchoolsApi.Root.User

    @valid_attrs %{address: "some address", email: "some email", name: "some name", phone: "some phone"}
    @update_attrs %{address: "some updated address", email: "some updated email", name: "some updated name", phone: "some updated phone"}
    @invalid_attrs %{address: nil, email: nil, name: nil, phone: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Root.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Root.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Root.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Root.create_user(@valid_attrs)
      assert user.address == "some address"
      assert user.email == "some email"
      assert user.name == "some name"
      assert user.phone == "some phone"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Root.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Root.update_user(user, @update_attrs)
      assert user.address == "some updated address"
      assert user.email == "some updated email"
      assert user.name == "some updated name"
      assert user.phone == "some updated phone"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Root.update_user(user, @invalid_attrs)
      assert user == Root.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Root.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Root.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Root.change_user(user)
    end
  end
end
