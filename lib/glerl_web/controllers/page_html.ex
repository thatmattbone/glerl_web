defmodule Glerl.Web.PageHTML do
  use Glerl.Web, :html

  alias Contex.{Dataset, Plot, PointPlot}

  embed_templates "page_html/*"


  attr :timestamp, :any, required: true
  def date_format(assigns) do
    formatted_timestamp = Calendar.strftime(assigns.timestamp, "%m/%d %H:%M")

    assigns = assigns |> assign(formatted_timestamp: formatted_timestamp)

    ~H"""
    <%= @formatted_timestamp %>
    """
  end

  def point_plot(assigns) do
    dataset = [{1, 10}, {2, 20}, {3, 30}, {4, 40}, {5, 50}]
      |> Dataset.new(["X", "Something"])

    options = [
      mapping: %{x_col: "X", y_cols: ["Something"]} #, "Another"]},
    ]

    plot = Plot.new(dataset, PointPlot, 500, 300, options)
      |> Plot.titles("Sample Scatter Plot", nil)
      |> Plot.plot_options(%{legend_setting: :legend_right})

    svg = Plot.to_svg(plot)

    assigns = assigns |> assign(svg: svg)

    ~H"""
    <%= @svg %>
    """
  end
end
