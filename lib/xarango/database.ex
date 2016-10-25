defmodule Xarango.Database do
  
  alias Xarango.Database
  alias Xarango.Client
  
  defstruct [:id, :name, :isSystem, :path, :users]
  
  def databases() do
    url = "/_api/database"
    Client.get(url)
    |> Enum.map(fn name -> struct(Database, [name: name])  end)
  end
  
  def user_databases() do
    url("user")
    |> Client.get
    |> Map.get(:result)
    |> Enum.map(&to_database(%{name: &1}))
  end
  
  def database(database) do
    db_url(database, "current")
    |> Client.get
    |> to_database
  end
  
  def create(database) do
    url("")
    |> Client.post(database)
    database
  end
  
  def destroy(database) do
    url(database.name)
    |> Client.delete
  end
  
  defp to_database(data) do
    struct(Database, Map.get(data, :result, data))
  end

  defp url(path, options\\[]) do
    "/_api/database/#{path}"
  end
  
  defp db_url(database, path, options\\[]) do
    "/_db/#{database.name}/_api/database/#{path}"
  end

  
  
end