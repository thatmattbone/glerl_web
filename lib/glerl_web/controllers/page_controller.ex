defmodule Glerl.Web.PageController do
  use Glerl.Web, :controller

  def current_conditions(conn, _params) do
    latest_glerl_data = Glerl.Realtime.Client.latest(90)  # two minute increments so this is an hour.

    conn
      |> assign(:data, latest_glerl_data)
      |> assign(:nav, :current_conditions)
      |> render(:current_conditions)
  end

  def previous_days(conn, _params) do
    conn
      |> assign(:nav, :previous_days)
      |> render(:previous_days)
  end

  def historical_conditions(conn, _params) do
    conn
      |> assign(:nav, :historical_conditions)
      |> render(:historical_conditions)
  end

  def about(conn, _params) do
    render(conn, :about, nav: nil)
  end
end
