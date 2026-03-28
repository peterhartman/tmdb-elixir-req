defmodule TmdbElixirReq.People do
  @moduledoc """
  Used for making calls related to people (actors and crew members).
  """

  alias TmdbElixirReq.Base

  @doc """
  Get the top level details of a person by ID.

  Returns a map with data for the corresponding person.

  Accepts query params listed in the [TMDb Docs](https://developer.themoviedb.org/reference/person-details) in the form of a map.

  ## Examples

      iex> TmdbElixirReq.People.find(287)["name"]
      "Brad Pitt"
  """
  def find(id, params \\ %{}) do
    Base.get!("person/#{id}?#{URI.encode_query(params)}").body
  end
end
