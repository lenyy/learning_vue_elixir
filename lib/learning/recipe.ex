defmodule Learning.Recipe do
    use Ecto.Schema
    import Ecto.Changeset

    alias Learning.Ingredient
    alias Learning.Accounts.User

    schema "recipe" do
        field :name, :string
        field :description, :string
        field :image, :string
        many_to_many :ingredients, Ingredient, join_through: "recipe_ingredients"
        many_to_many :users, User, join_through: "users_recipes"
    end

    def changeset(recipe, attrs) do
        recipe
        |> cast(attrs, [:name, :description, :image, :ingredients, :users])
        |> validate_required([:name, :description, :image])
        |> validate_length(:ingredients, min: 1)
    end
end
