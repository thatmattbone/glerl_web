defmodule Glerl.Web.PageHTML do
  use Glerl.Web, :html

  embed_templates "page_html/*"

  def my_new_thing(assigns) do
    IO.inspect(assigns)

    ~H"""
    <p> This is my new thing. <%= @fuck %></p>
    """
  end
end
