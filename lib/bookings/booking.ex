defmodule Flightex.Bookings.Booking do
  @keys [:id, :data_completa, :cidade_origem, :cidade_destino, :id_usuario]
  @enforce_keys [:data_completa, :cidade_origem, :cidade_destino, :id_usuario]

  defstruct @keys

  def build(id_usuario, cidade_origem, cidade_destino, data_completa) do
    data_completa
    |> parse_date()
    |> handle_build(id_usuario, cidade_origem, cidade_destino)
  end

  def build(_id_usuario, _cidade_origem, _cidade_destino, _data_completa) do
    {:error, "Invalid parameters!"}
  end

  defp handle_build({:error, reason}, _id_usuario, _cidade_origem, _cidade_destino) do
    {:error, reason}
  end

  defp handle_build(data_completa, id_usuario, cidade_origem, cidade_destino) do
    uuid = UUID.uuid4()
    {:ok}

    {
      :ok,
      %__MODULE__{
        id: uuid,
        id_usuario: id_usuario,
        cidade_origem: cidade_origem,
        cidade_destino: cidade_destino,
        data_completa: data_completa
      }
    }
  end

  defp parse_date(date) when is_bitstring(date) do
    case NaiveDateTime.from_iso8601(date) do
      {:ok, date} -> date
      {:error, _reason} -> {:error, "Invalid date, cannot convert string to date"}
    end
  end

  defp parse_date(%NaiveDateTime{} = date), do: date

  defp parse_date(_date), do: {:error, "Invalid date"}
end
