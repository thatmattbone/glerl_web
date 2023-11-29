defmodule Glerl.Web.PageController do
  use Glerl.Web, :controller

  def current_conditions(conn, _params) do
    render(conn, :home)
  end

  def second_home(conn, _params) do
    #latest_glerl_data = Glerl.Realtime.Client.latest(30)  # two minute increments so this is an hour.
    latest_glerl_data = Glerl.Realtime.Client.latest()

    conn
    |> assign(:data, latest_glerl_data)
    |> render(:home)
  end
end
