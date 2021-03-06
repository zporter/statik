defmodule StatikWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use StatikWeb, :controller
      use StatikWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: StatikWeb

      import Plug.Conn
      import StatikWeb.Gettext
      alias StatikWeb.Router.Helpers, as: Routes
    end
  end

  def view(options \\ []) do
    options =
      [
        root: "lib/statik_web/templates",
        namespace: StatikWeb
      ]
      |> Keyword.merge(options)

    quote do
      use Phoenix.View, unquote(options)

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_flash: 1, get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import StatikWeb.ErrorHelpers
      import StatikWeb.Gettext
      alias StatikWeb.Router.Helpers, as: Routes
    end
  end

  def nested_view do
    view(pattern: "**/*")
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import StatikWeb.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
