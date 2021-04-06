defmodule SchoolsApiWeb.DefaultController do
  use SchoolsApiWeb, :controller

  def index(conn, _params) do
    text conn, "SchoolsApi!"
  end
end
