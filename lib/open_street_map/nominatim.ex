defmodule OpenStreetMap.Nominatim do
  import OpenStreetMap.Http

  @doc """
  The search API allows you to look up a location from a textual description or address. Nominatim supports structured and free-form search queries.
  """
  @spec search(params) :: {:ok, list(map())} | {:error, any()}
        when params: %{
               optional(:q) => String.t(),
               optional(:street) => String.t(),
               optional(:city) => String.t(),
               optional(:county) => String.t(),
               optional(:state) => String.t(),
               optional(:country) => String.t(),
               optional(:postalcode) => String.t(),
               optional(:polygon_geojson) => integer()
             }
  def search(params), do: request(:get, "search", Map.put_new(params, :format, "json"))
end
