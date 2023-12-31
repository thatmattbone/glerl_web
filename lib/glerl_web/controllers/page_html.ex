defmodule Glerl.Web.PageHTML do
  use Glerl.Web, :html

  alias Contex.{Dataset, Plot, PointPlot, LinePlot, ContinuousLinearScale, Scale}

  embed_templates "page_html/*"


  attr :timestamp, :any, required: true
  def date_format(assigns) do
    chicago_time = DateTime.shift_zone!(assigns.timestamp, "America/Chicago")

    formatted_timestamp = Calendar.strftime(chicago_time, "%m/%d %H:%M")

    assigns = assigns |> assign(formatted_timestamp: formatted_timestamp)

    ~H"""
    <%= @formatted_timestamp %>
    """
  end

  attr :temp_c, :float, required: true
  def temp_format(assigns) do
    fahrenheit = (assigns.temp_c * (9/5)) + 32

    assigns = assigns |> assign(fahrenheit: fahrenheit)

    ~H"""
    <%= @fahrenheit %>
    """
  end
  

  attr :date, :any, required: true
  def point_plot(assigns) do
    # IO.inspect(assigns.data)

    dataset = for datapoint <- assigns.data do
      chicago_time = DateTime.shift_zone!(datapoint.timestamp, "America/Chicago")

      {
        chicago_time,
        datapoint.speed,
        datapoint.gusts,
        15,
        20
      }
    end

    # [{1, 50, 52}, {2, 20, 24}, {3, 30, 31}, {4, 5, 7}, {5, 10, 13}]
    dataset = dataset
      |> Dataset.new(["X", "Wind Speed", "Gusting To", "15", "20"])

    y_scale = ContinuousLinearScale.new()
      |> ContinuousLinearScale.domain(0.0, 30.0)
      |> Scale.set_range(0.0, 30.0)

    options = [
      mapping: %{x_col: "X", y_cols: ["Wind Speed", "Gusting To", "15", "20"]},
      custom_y_scale:  y_scale
    ]

    plot = Plot.new(dataset, LinePlot, 900, 500, options)
      # |> Plot.titles("Sample Scatter Plot", nil)
      |> Plot.plot_options(%{legend_setting: :legend_right})

    svg = Plot.to_svg(plot)

    assigns = assigns |> assign(svg: svg)

    ~H"""
    <%= @svg %>
    """
  end
end
