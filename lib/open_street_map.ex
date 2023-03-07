defmodule OpenStreetMap do
  @moduledoc """
  An Elixir wrapper for Open Street Map Nominatim's API.
  Only a subset of the API is supported and this is a work in progress. That said, any modules that have been implemented can be used.
  For general reference please see: https://nominatim.org/release-docs/develop/api/Overview/
  """

  defdelegate search(params), to: OpenStreetMap.Nominatim
end
