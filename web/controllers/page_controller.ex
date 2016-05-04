defmodule GetAtMe.PageController do
  use GetAtMe.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
