defmodule Glerl.Web.PageController do
  use Glerl.Web, :controller

  def current_conditions(conn, _params) do
    latest_glerl_data = Glerl.Realtime.Client.latest(120)  # two minute increments so this is four hours

    [%{timestamp: timestamp} | _] = latest_glerl_data
    timestamp_diff = DateTime.utc_now() |> DateTime.diff(timestamp, :minute)
    is_data_stale = timestamp_diff > 30  # minutes

    conn
      |> assign(:data, latest_glerl_data)
      |> assign(:is_data_stale, is_data_stale)
      |> assign(:timestamp_diff, timestamp_diff)
      |> assign(:nav, :current_conditions)
      |> render(:current_conditions)
  end

  def historical_conditions(conn, _params) do
    conn
      |> assign(:nav, :historical_conditions)
      |> render(:historical_conditions_landing_page)
  end

  def about(conn, _params) do
    render(conn, :about, nav: nil)
  end
end
