defmodule StatikWeb.PageControllerTest do
  use StatikWeb.ConnCase, async: true

  [
    {"/", "Welcome to Phoenix!"},
    {"/privacy", "Privacy Policy"},
    {"/terms", "Terms & Conditions"},
    {"/work/acme-corp", "Working with Acme Corp."},
    {"/work/beta-inc", "Working with Beta Inc."}
  ]
  |> Enum.each(fn {path, contents} ->
    test "GET #{path}", %{conn: conn} do
      conn = get(conn, unquote(path))
      assert html_response(conn, 200) =~ unquote(contents)
    end
  end)

  test "invalid template renders missing", %{conn: conn} do
    conn = get(conn, "/lolwut")

    assert html_response(conn, 404)
  end
end
