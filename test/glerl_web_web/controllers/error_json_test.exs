defmodule Glerl.WebWeb.ErrorJSONTest do
  use Glerl.WebWeb.ConnCase, async: true

  test "renders 404" do
    assert Glerl.WebWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert Glerl.WebWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
