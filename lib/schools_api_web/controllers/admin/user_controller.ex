defmodule SchoolsApiWeb.Admin.UserController do
  use SchoolsApiWeb, :controller

  alias SchoolsApi.Root
  alias SchoolsApi.Root.User

  action_fallback SchoolsApiWeb.FallbackController

  def index(conn, _params) do
    users = Root.list_users(0)
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Root.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.admin_user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Root.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Root.get_user!(id)

    with {:ok, %User{} = user} <- Root.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Root.get_user!(id)

    with {:ok, %User{}} <- Root.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
