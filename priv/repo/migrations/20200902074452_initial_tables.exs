defmodule Learning.Repo.Migrations.InitialTables do
    use Ecto.Migration

    def change do
        create table(:user) do
            add :username, :string, null: false
            add :email, :string, null: false
            add :password, :string, null: false
        end

        create table(:recipe) do
            add :name, :string, null: false
            add :description, :string
            add :image, :string
        end

        create table(:ingredient) do
            add :name, :string, null: false
            add :type, :string, null: false
            add :image, :string
        end

        create table(:users_recipes) do
            add :user_id, references(:user)
            add :recipe_id, references(:recipe)
        end

        create table(:recipe_ingredients) do
            add :recipe_id, references(:recipe)
            add :ingredient_id, references(:ingredient)
        end

        create unique_index(:users_recipes, [:user_id, :recipe_id])
        create unique_index(:recipe_ingredients, [:recipe_id, :ingredient_id])
    end
end
