defmodule Discuss.User do
	use Discuss.Web, :model

	schema "users" do
		field :email, :string
		field :username, :string
		field :provider, :string
		field :token, :string
		has_many :comments, Discuss.Comment
		has_many :topics, Discuss.Topic

		timestamps()
	end

	def changeset(struct, params \\ %{}) do
		struct
		|> cast(params, [:email, :provider, :token, :username])
		|> validate_required([:email, :provider, :token, :username])
	end
end