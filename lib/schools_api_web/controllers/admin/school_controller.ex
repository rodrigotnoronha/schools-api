defmodule SchoolsApiWeb.Admin.SchoolController do
  use SchoolsApiWeb, :controller

  alias SchoolsApi.Root
  alias SchoolsApi.Root.School

  action_fallback SchoolsApiWeb.FallbackController

  def index(conn, _params) do
    schools = Root.list_schools()
    render(conn, "index.json", schools: schools)
  end

  def create(conn, %{"school" => school_params}) do
    with {:ok, %School{} = school} <- Root.create_school(school_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.admin_school_path(conn, :show, school))
      |> render("show.json", school: school)
    end
  end

  def show(conn, %{"id" => id}) do
    school = Root.get_school!(id)
    render(conn, "show.json", school: school)
  end

  def update(conn, %{"id" => id, "school" => school_params}) do
    school = Root.get_school!(id)

    with {:ok, %School{} = school} <- Root.update_school(school, school_params) do
      render(conn, "show.json", school: school)
    end
  end

  def delete(conn, %{"id" => id}) do
    school = Root.get_school!(id)

    with {:ok, %School{}} <- Root.delete_school(school) do
      send_resp(conn, :no_content, "")
    end
  end
end
