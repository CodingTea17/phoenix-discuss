defmodule Discuss.Router do
  use Discuss.Web, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", Discuss do
    # Use the default browser stack
    pipe_through(:browser)

    get("/hello/:name", HelloController, :helloElixir)

    # Phoenix has resources too
    resources("/topics", TopicController)

    # get   "/", PageController, :index

    # Sets the sites index to the topics index
    # get("/", Redirect, to: "/topics")
    # get("/topics/new", TopicController, :new)
    # post("/topics/create", TopicController, :create)
    # get("/topics/:id/edit", TopicController, :edit)
    # put("/topics/:id/update", TopicController, :update)
    # delete("/topics/:id"), TopicController, :delete)
  end

  # Other scopes may use custom stacks.
  # scope "/api", Discuss do
  #   pipe_through :api
  # end
end
