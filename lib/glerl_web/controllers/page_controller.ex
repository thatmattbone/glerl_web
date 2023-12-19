defmodule Glerl.Web.PageController do
  use Glerl.Web, :controller

  def current_conditions(conn, _params) do
    latest_glerl_data =
      Glerl.Realtime.Client.latest(30)  # two minute increments so this is an hour.

    conn
    |> assign(:data, latest_glerl_data)
    |> assign(:nav, :current_conditions)
    |> render(:current_conditions)
  end

  # def make_a_basic_point_plot() do
  #   dataset = make_test_point_data(300)

  #   options = [
  #     mapping: %{x_col: "X", y_cols: ["Something", "Another"]},
  #   ]

  #   plot = Plot.new(dataset, PointPlot, 500, 300, options)
  #     |> Plot.titles("Sample Scatter Plot", nil)
  #     |> Plot.plot_options(%{legend_setting: :legend_right})

  #   Plot.to_svg(plot)
  # end  

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
