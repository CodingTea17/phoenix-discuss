defmodule Discuss.User do
	use Discuss.Web, :model

	schema "users" do
		field :email, :string
		field :username, :string
		field :provider, :string
		field :token, :string

		timestamps()
	end

	def changeset(struct, params \\ %{}) do
		struct
		|> cast(params, [:email, :provider, :token, :username])
		|> validate_required([:email, :provider, :token, :username])
	end
end