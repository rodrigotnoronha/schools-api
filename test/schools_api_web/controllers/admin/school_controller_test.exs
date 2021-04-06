defmodule SchoolsApiWeb.Admin.SchoolControllerTest do
  use SchoolsApiWeb.ConnCase

  alias SchoolsApi.Root
  alias SchoolsApi.Root.School

  @create_attrs %{
    address: "some address",
    name: "some name",
    phone: "some phone"
  }
  @update_attrs %{
    address: "some updated address",
    name: "some updated name",
    phone: "some updated phone"
  }
  @invalid_attrs %{address: nil, name: nil, phone: nil}

  def fixture(:school) do
    {:ok, school} = Root.create_school(@create_attrs)
    school
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all schools", %{conn: conn} do
      conn = get(conn, Routes.admin_school_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create school" do
    test "renders school when data is valid", %{conn: conn} do
      conn = post(conn, Routes.admin_school_path(conn, :create), school: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.admin_school_path(conn, :show, id))

      assert %{
               "id" => id,
               "address" => "some address",
               "name" => "some name",
               "phone" => "some phone"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.admin_school_path(conn, :create), school: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update school" do
    setup [:create_school]

    test "renders school when data is valid", %{conn: conn, school: %School{id: id} = school} do
      conn = put(conn, Routes.admin_school_path(conn, :update, school), school: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.admin_school_path(conn, :show, id))

      assert %{
               "id" => id,
               "address" => "some updated address",
               "name" => "some updated name",
               "phone" => "some updated phone"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, school: school} do
      conn = put(conn, Routes.admin_school_path(conn, :update, school), school: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete school" do
    setup [:create_school]

    test "deletes chosen school", %{conn: conn, school: school} do
      conn = delete(conn, Routes.admin_school_path(conn, :delete, school))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.admin_school_path(conn, :show, school))
      end
    end
  end

  defp create_school(_) do
    school = fixture(:school)
    %{school: school}
  end
end
