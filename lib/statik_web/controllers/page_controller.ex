defmodule StatikWeb.PageController do
  use StatikWeb, :controller

  @spec index(Plug.Conn.t(), map) :: Plug.Conn.t()
  def index(conn, _params) do
    render(conn, "index.html")
  end

  @spec show(Plug.Conn.t, map) :: Plug.Conn.t
  def show(conn, %{"path" => path_parts}) do
    template = Path.join(path_parts)

    render(conn, "#{template}.html")

  rescue
    Phoenix.Template.UndefinedError ->
      conn
      |> put_status(:not_found)
      |> put_view(StatikWeb.ErrorView)
      |> render(:"404")
  end
end
