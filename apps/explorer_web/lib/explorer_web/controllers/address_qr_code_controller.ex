defmodule ExplorerWeb.AddressQRCodeController do
  use ExplorerWeb, :controller

  alias Explorer.Chain.Hash.Truncated

  def index(conn, %{"address_id" => id}) do
    case Truncated.cast(id) do
      {:ok, _} ->
        send_download(conn, {:binary, QRCode.to_png(id)}, "content-type": "image/png", filename: "#{id}.png")

      _ ->
        send_resp(conn, :not_found, "")
    end
  end
end