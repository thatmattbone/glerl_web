defmodule Glerl.Web.PageHTML do
  @moduledoc """
  This module contains pages rendered by PageController.

  See the `page_html` directory for all templates available.
  """
  use Glerl.Web, :html

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


  def direction_format(assigns) do
    formatted_direction = Glerl.Core.Conversion.degrees_to_direction(assigns.direction)

    assigns = assigns |> assign(formatted_direction: formatted_direction)

    ~H"""
    <%= @formatted_direction %>
    """
  end

  attr :data, :any, required: true
  def wind_speed_plot(assigns) do
    plot = Glerl.Web.Plots.Builder.build_wind_speed_plot(assigns.data)
    svg = Plot.to_svg(plot)

    assigns = assigns |> assign(svg: svg)

    ~H"""
    <%= @svg %>
    """
  end

  attr :data, :any, required: true
  def wind_direction_plot(assigns) do
    plot = Glerl.Web.Plots.Builder.build_wind_direction_plot(assigns.data)
    svg = Plot.to_svg(plot)

    assigns = assigns |> assign(svg: svg)

    ~H"""
    <%= @svg %>
    """
  end

  # attr :sailing_session, :atom, required: true
  # attr :for_date, :string, required: true
  def historical_conditions_form(assigns) do
    ~H"""
    <.historical_conditions_form />
    """
  end
end
