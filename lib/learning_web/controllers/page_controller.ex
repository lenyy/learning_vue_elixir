defmodule LearningWeb.PageController do
  use LearningWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
