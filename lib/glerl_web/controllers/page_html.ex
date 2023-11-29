defmodule Glerl.Web.PageHTML do
  use Glerl.Web, :html

  embed_templates "page_html/*"


  attr :timestamp, :any, required: true
  def date_format(assigns) do
    formatted_timestamp = Calendar.strftime(assigns.timestamp, "%m/%d %H:%M")

    assigns = assigns |> assign(formatted_timestamp: formatted_timestamp)

    ~H"""
    <%= @formatted_timestamp %>
    """
  end
end
