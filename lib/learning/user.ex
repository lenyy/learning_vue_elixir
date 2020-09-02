defmodule Learning.User do
    use Ecto.Schema
    import Ecto.Changeset

    schema "user" do
        field :username, :string
        field :email, :string
        field :password, :string
        many_to_many :recipes, Learning.Recipe, join_through: "users_recipes"
    end

    def changeset(%User{} = user, params) do
        user
        |> cast(params, [:username, :email, :password])
        |> validate_required([:username, :email, :password])
    end


end
