defmodule Learning.Ingredient do
    use Ecto.Schema

    schema "ingredient" do
        field :name, :string
        field :type, :string
        field :image, :string
        many_to_many :recipes, Learning.Recipe, join_through: "recipe_ingredients"
    end

    def changeset(%Ingredient{} = ingredient, attrs) do
        ingredient
        |> cast(attrs, [:name, :type, :image, :recipes])
        |> validate_required([:name, :type])
    end
end
