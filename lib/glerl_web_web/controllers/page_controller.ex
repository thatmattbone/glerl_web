defmodule Glerl.WebWeb.PageController do
  use Glerl.WebWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def second_home(conn, _params) do
    latest_glerl_data = Glerl.Realtime.Client.latest()
    IO.inspect(latest_glerl_data)
    conn
    |> assign(:data, latest_glerl_data)
    |> render(:home)
  end
end
