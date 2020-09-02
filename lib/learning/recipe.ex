defmodule Learning.Recipe do
    use Ecto.Schema

    schema "recipe" do
        field :name, :string
        field :description, :string
        field :image, :string
        many_to_many :ingredients, Learning.Ingredient, join_through: "recipe_ingredients"
        many_to_many :users, Learning.User, join_through: "users_recipes"
    end

    def changeset(%Recipe{} = recipe, attrs) do
        recipe
        |> cast(attrs, [:name, :description, :image, :ingredients, :users])
        |> validate_required([:name, :description, :image])
        |> validate_length(:ingredients, min: 1)
    end
end
