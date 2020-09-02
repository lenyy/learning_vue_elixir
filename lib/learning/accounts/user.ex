defmodule Learning.Accounts.User do
    use Ecto.Schema
    import Ecto.Changeset

    alias Learning.Recipe
    alias Learning.Accounts.Credential

    schema "user" do
        field :username, :string
        field :email, :string
        field :password, :string
        many_to_many :recipes, Recipe, join_through: "users_recipes"
        has_one :credential, Credential

        timestamps()
    end

    def changeset(user, params) do
        user
        |> cast(params, [:username, :email, :password])
        |> validate_required([:username, :email, :password])
        |> unique_constraint(:username)
    end


end
