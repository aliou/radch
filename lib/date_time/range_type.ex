defmodule DateTime.RangeType do
  @behaviour Ecto.Type

  @impl Ecto.Type
  def type, do: :tsrange

  @impl Ecto.Type
  def cast(term)
  def cast(%DateTime.Range{} = range), do: {:ok, range}
  def cast(_), do: :error

  @impl Ecto.Type
  def load(term)

  def load(%Postgrex.Range{} = range) do
    {:ok,
     DateTime.Range.new(range.lower, range.upper, range.lower_inclusive, range.upper_inclusive)}
  end

  def load(_), do: :error

  @impl Ecto.Type
  def dump(%DateTime.Range{} = range) do
    {:ok,
     %Postgrex.Range{
       lower: range.lower |> DateTime.to_naive(),
       upper: range.upper |> DateTime.to_naive(),
       lower_inclusive: range.lower_inclusive,
       upper_inclusive: range.upper_inclusive
     }}
  end

  def dump(_), do: :error
end
