defmodule Discuss.TopicController do
  use Discuss.Web, :controller

  # Same as: 
  # alias Discuss.Topic, as: Topic
  alias Discuss.Topic

  def index(conn, _params) do
    IO.inspect(conn.assigns)
    topics = Repo.all(Topic)

    render(conn, "index.html", topics: topics)
  end

  # Renders a page with a form to make a new Topic
  def new(conn, _params) do
    # Validates the params
    changeset = Topic.changeset(%Topic{}, %{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{ "topic" => topic }) do
    changeset = Topic.changeset(%Topic{}, topic)

    case Repo.insert(changeset) do
      { :ok, _topic } ->
        conn
        |> put_flash(:info, "Topic Created")
        |> redirect(to: topic_path(conn, :index))

      { :error, changeset } ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{ "id" => topic_id }) do
	topic = Repo.get(Topic, topic_id)
	changeset = Topic.changeset(topic)

	render conn, "edit.html", changeset: changeset, topic: topic
  end

  def update(conn, %{ "id" => topic_id, "topic" => topic }) do
    old_topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(old_topic, topic)
    
    # Cool elixir way: get old topic and pipe it in as the first argument to the changeset method
    # changeset = Repo.get(Topic, topic_id) |> Topic.changeset(topic)

    case Repo.update(changeset) do
      { :ok, _topic } ->
        conn
        |> put_flash(:info, "Topic Updated")
        |> redirect(to: topic_path(conn, :index))
      { :error, changeset } ->
        render(conn, "edit.html", changeset: changeset, topic: old_topic)
    end
  end

  def delete(conn, %{ "id" => topic_id }) do
    Repo.get!(Topic, topic_id) |> Repo.delete!

    conn
    |> put_flash(:info, "Topic Deleted")
    |> redirect(to: topic_path(conn, :index))
  end

end
