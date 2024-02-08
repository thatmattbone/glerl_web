defmodule Glerl.Web.PageHTML do
  use Glerl.Web, :html

  alias Contex.{Dataset, Plot, LinePlot, ContinuousLinearScale, TimeScale, Scale}

  embed_templates "page_html/*"

  def hello_world() do
    "HELLO WORLD!!"
  end


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
    fahrenheit = (assigns.temp_c * (9/5)) + 32 |> Float.round(1)

    assigns = assigns |> assign(fahrenheit: fahrenheit)

    ~H"""
    <%= @fahrenheit %>
    """
  end
  

  attr :num, :float, required: true
  def float_format(assigns) do
    formatted_float = Float.round(assigns.num, 1)

    assigns = assigns |> assign(formatted_float: formatted_float)

    ~H"""
    <%= @formatted_float %>
    """
  end

  attr :data, :any, required: true
  def point_plot(assigns) do
    # dataset = for datapoint <- assigns.data do
    #   chicago_time = DateTime.shift_zone!(datapoint.timestamp, "America/Chicago")

    #   {
    #     chicago_time,
    #     datapoint.speed,
    #     datapoint.gusts,
    #     15,
    #     20
    #   }
    # end

    # dataset = dataset
    #   |> Dataset.new(["X", "Wind Speed", "Gusting To", "15", "20"])

    # y_scale = ContinuousLinearScale.new()
    #   |> ContinuousLinearScale.domain(0.0, 30.0)
    #   |> Scale.set_range(0.0, 30.0)
    # y_scale = %{y_scale | interval_count: 6, interval_size: 5, display_decimals: 0}

    # x_scale = TimeScale.new()
    #   |> TimeScale.domain(List.first(assigns.data).timestamp |> DateTime.shift_zone!("America/Chicago"), 
    #                       List.last(assigns.data).timestamp  |> DateTime.shift_zone!("America/Chicago"))
    # x_scale = %{x_scale | display_format: "%H:%M"}

    # options = [
    #   mapping: %{x_col: "X", y_cols: ["Wind Speed", "Gusting To", "15", "20"]},
    #   custom_y_scale:  y_scale,
    #   custom_x_scale: x_scale,
    #   legend_setting: :legend_none
    # ]

    # plot = Plot.new(dataset, LinePlot, 900, 500, options)
    # svg = Plot.to_svg(plot)

    plot = GlerlWeb.Plots.Builder.build_point_plot(assigns.data)
    svg = Plot.to_svg(plot)

    assigns = assigns |> assign(svg: svg)

    ~H"""
    <%= @svg %>
    """
  end
end
