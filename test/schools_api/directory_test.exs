defmodule SchoolsApi.DirectoryTest do
  use SchoolsApi.DataCase

  alias SchoolsApi.Directory

  describe "schools" do
    alias SchoolsApi.Directory.School

    @valid_attrs %{address: "some address", name: "some name", phone: "some phone"}
    @update_attrs %{address: "some updated address", name: "some updated name", phone: "some updated phone"}
    @invalid_attrs %{address: nil, name: nil, phone: nil}

    def school_fixture(attrs \\ %{}) do
      {:ok, school} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Directory.create_school()

      school
    end

    test "list_schools/0 returns all schools" do
      school = school_fixture()
      assert Directory.list_schools() == [school]
    end

    test "get_school!/1 returns the school with given id" do
      school = school_fixture()
      assert Directory.get_school!(school.id) == school
    end

    test "create_school/1 with valid data creates a school" do
      assert {:ok, %School{} = school} = Directory.create_school(@valid_attrs)
      assert school.address == "some address"
      assert school.name == "some name"
      assert school.phone == "some phone"
    end

    test "create_school/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Directory.create_school(@invalid_attrs)
    end

    test "update_school/2 with valid data updates the school" do
      school = school_fixture()
      assert {:ok, %School{} = school} = Directory.update_school(school, @update_attrs)
      assert school.address == "some updated address"
      assert school.name == "some updated name"
      assert school.phone == "some updated phone"
    end

    test "update_school/2 with invalid data returns error changeset" do
      school = school_fixture()
      assert {:error, %Ecto.Changeset{}} = Directory.update_school(school, @invalid_attrs)
      assert school == Directory.get_school!(school.id)
    end

    test "delete_school/1 deletes the school" do
      school = school_fixture()
      assert {:ok, %School{}} = Directory.delete_school(school)
      assert_raise Ecto.NoResultsError, fn -> Directory.get_school!(school.id) end
    end

    test "change_school/1 returns a school changeset" do
      school = school_fixture()
      assert %Ecto.Changeset{} = Directory.change_school(school)
    end
  end
end
