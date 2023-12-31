defmodule Glerl.Web.PageHTML do
  use Glerl.Web, :html

  alias Contex.{Dataset, Plot, PointPlot, LinePlot}

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
    dataset = [{1, 50, 52}, {2, 20, 24}, {3, 30, 31}, {4, 5, 7}, {5, 10, 13}]
      |> Dataset.new(["X", "Something", "Another Something"])

    options = [
      mapping: %{x_col: "X", y_cols: ["Something", "Another Something"]}
    ]

    plot = Plot.new(dataset, LinePlot, 900, 500, options)
      |> Plot.titles("Sample Scatter Plot", nil)
      |> Plot.plot_options(%{legend_setting: :legend_right})

    svg = Plot.to_svg(plot)

    assigns = assigns |> assign(svg: svg)

    ~H"""
    <%= @svg %>
    """
  end
end
