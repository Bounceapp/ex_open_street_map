defmodule OpenStreetMap.Http do
  use HTTPoison.Base

  def request(:get, url, params) do
    case get(url, [],
           params: params,
           timeout: 15_000,
           recv_timeout: 15_000
         ) do
      {:ok, %HTTPoison.Response{body: body}} ->
        body

      {:error, error} ->
        raise "OpenStreetMap.HttpClient error: #{error}"
    end
  end

  def request(:delete, url, params) do
    case delete(url, [],
           params: params,
           timeout: 15_000,
           recv_timeout: 15_000
         ) do
      {:ok, %HTTPoison.Response{body: body}} ->
        body

      {:error, error} ->
        raise "OpenStreetMap.HttpClient error: #{error}"
    end
  end

  def request(:post, url, body_params, query_params) do
    case post(
           url,
           Poison.encode!(body_params),
           ["Content-Type": "application/json"],
           params: query_params,
           timeout: 15_000,
           recv_timeout: 15_000
         ) do
      {:ok, %HTTPoison.Response{body: body}} ->
        body

      {:error, error} ->
        raise "OpenStreetMap.HttpClient error: #{error}"
    end
  end

  def process_request_url(url) do
    "https://nominatim.openstreetmap.org/" <> url
  end

  def process_response_body(body) do
    body
    |> Poison.decode!()
    |> atomize_keys()
    |> case do
      %{error: _} = r -> {:error, r}
      data -> {:ok, data}
    end
  end

  #######################################################
  ### Atomize Keys
  #######################################################

  @doc """
  Convert map string keys to :atom keys
  """
  defp atomize_keys(nil), do: nil

  defp atomize_keys(%{__struct__: _} = struct) do
    struct
  end

  defp atomize_keys(%{} = map) do
    map
    |> Enum.map(fn {k, v} -> {to_atom(k), atomize_keys(v)} end)
    |> Enum.into(%{})
  end

  defp atomize_keys([head | rest]) do
    [atomize_keys(head) | atomize_keys(rest)]
  end

  defp atomize_keys(not_a_map), do: not_a_map

  defp to_atom(str) when is_bitstring(str), do: String.to_atom(str)
  defp to_atom(str) when is_atom(str), do: str
end
