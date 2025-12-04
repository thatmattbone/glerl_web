defmodule Glerl.WebWeb.PageController do
  use Glerl.WebWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
