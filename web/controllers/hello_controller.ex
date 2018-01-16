defmodule Discuss.HelloController do
  use Discuss.Web, :controller

  def helloElixir(conn, %{ "name" => name }) do
    render(conn, "world.html", name: name)
  end
end
