defmodule Glerl.Web.PageController do
  use Glerl.Web, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def second_home(conn, _params) do
    #latest_glerl_data = Glerl.Realtime.Client.latest(30)  # two minute increments so this is an hour.
    latest_glerl_data = Glerl.Realtime.Client.latest()

    conn
    |> assign(:data, latest_glerl_data)
    |> render(:home)
  end
end
