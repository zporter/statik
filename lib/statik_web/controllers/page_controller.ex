defmodule StatikWeb.PageController do
  use StatikWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
