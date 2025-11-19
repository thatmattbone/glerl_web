defmodule Glerl.Web.PageController do
  use Glerl.Web, :controller

  def current_conditions(conn, _params) do
    latest_glerl_data = Glerl.Realtime.Client.latest(120) |> Enum.reverse()  # two minute increments so this is four hours

    [%{timestamp: timestamp} | _] = latest_glerl_data
    timestamp_diff = DateTime.utc_now() |> DateTime.diff(timestamp, :minute)
    is_data_stale = timestamp_diff > 30  # minutes

    conn
      |> assign(:nav, :current_conditions)
      |> assign(:is_data_stale, is_data_stale)
      |> assign(:timestamp_diff, timestamp_diff)
      |> assign(:data, latest_glerl_data)
      |> render(:current_conditions)
  end

  defp get_sailing_session(_params=%{"morning" => "on"}), do: :morning
  defp get_sailing_session(_params=%{"afternoon" => "on"}), do: :afternoon
  defp get_sailing_session(_params=%{"evening" => "on"}), do: :evening
  defp get_sailing_session(_params), do: :morning

  defp get_historical_date(historical_date) do
    Date.from_iso8601!(historical_date)
  end

  def historical_conditions(conn, params = %{"historical_date" => historical_date}) do
    historical_date = get_historical_date(historical_date)
    sailing_session = get_sailing_session(params)

    historical_data = Glerl.Archive.Client.data_for_session(sailing_session, historical_date)

    conn
      |> assign(:nav, :historical_conditions)
      |> assign(:for_date, historical_date)
      |> assign(:sailing_session, sailing_session)
      |> assign(:data, historical_data)
      |> render(:historical_conditions)
  end

  def historical_conditions(conn, _params) do
    conn
      |> assign(:nav, :historical_conditions)
      |> assign(:sailing_session, :morning)
      |> assign(:for_date, "2024-04-11")
      |> render(:historical_conditions_landing_page)
  end

  def about(conn, _params) do
    render(conn, :about, nav: nil)
  end
end
