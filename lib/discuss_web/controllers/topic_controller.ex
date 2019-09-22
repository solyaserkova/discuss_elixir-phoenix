defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

  alias Discuss.Repo
  alias DiscussWeb.Topic

  # GET 'topics/'
  def index(conn, _params) do
    topics = Repo.all(Topic)

    render(conn, "index.html", topics: topics)
  end

  # GET 'topics/new'
  def new(conn, _params) do
    # IO.inspect conn conn=connection is a struct, represents incoming and outgoing requests
    # IO.inspect params
    # struct = %Topic{}
    # params = %{}
    changeset = Topic.changeset(%Topic{}, %{})

    render(conn, "new.html", changeset: changeset)
  end

  # POST 'topics/'
  def create(conn, %{"topic" => topic}) do
    # %{"topic" => topic} = params
    changeset = Topic.changeset(%Topic{}, topic)

    case Repo.insert(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic created")
        |> redirect(to: Routes.topic_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  # DELETE 'topics/12'
  def delete(conn, %{"id" => topic_id}) do
    Repo.get!(Topic, topic_id)
    |> Repo.delete!()

    conn
    |> put_flash(:info, "Topic Deleted")
    |> redirect(to: Routes.topic_path(conn, :index))
  end

  # GET 'topics/12/edit'
  def edit(conn, %{"id" => topic_id}) do
    topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(topic)

    render(conn, "edit.html", changeset: changeset, topic: topic)
  end

  # PUT 'topics/12'
  def update(conn, %{"id" => topic_id, "topic" => topic}) do
    old_topic = Repo.get(Topic, topic_id)

    changeset =
      Repo.get(Topic, topic_id)
      |> Topic.changeset(topic)

    case Repo.update(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Updated")
        |> redirect(to: Routes.topic_path(conn, :index))

      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset, topic: old_topic)
    end
  end
end
