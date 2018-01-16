defmodule Discuss.TopicController do
    use Discuss.Web, :controller

    # Same as: 
    # alias Discuss.Topic, as: Topic
    alias Discuss.Topic

    # Renders a page with a form to make a new Topic
    def new(conn, _params) do
        # Validates the params
        changeset = Topic.changeset(%Topic{}, %{})

        render conn, "new.html", changeset: changeset
    end


    
    def create(conn, %{ "topic" => topic }) do
        changeset = Topic.changeset(%Topic{}, topic)

       case Repo.insert(changeset) do
            { :ok, post } -> IO.inspect(post)
            { :error, changeset } -> 
                render conn, "new.html", changeset: changeset
       end
        # IO.puts(conn.request_path)
    end
end