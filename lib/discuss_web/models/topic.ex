defmodule DiscussWeb.Topic do
  use DiscussWeb, :model

  # 1 hey phx look inside the postgres database find the table called topics
  schema "topics" do
    field :title, :string
  end

  # 2 validations; struct - db record; params - changes; cast returns changeset
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])
    |> validate_required([:title])
  end
end

# struct from where it is now to where it needs to be
# struct = %DiscussWeb.Topic{}
# params = %{title: "Great JS"}
# DiscussWeb.Topic.changeset(struct, params)
