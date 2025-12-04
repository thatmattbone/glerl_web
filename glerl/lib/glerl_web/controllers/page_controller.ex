defmodule Glerl.Web.PageController do
  use Glerl.Web, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
