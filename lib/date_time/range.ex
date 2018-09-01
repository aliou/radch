# TODO: Enumerable protocol
defmodule DateTime.Range do
  @behaviour Ecto.Type

  @enforce_keys [:lower, :upper]
  defstruct [:lower, :upper, lower_inclusive: true, upper_inclusive: true]

  @type t :: %__MODULE__{
          lower: DateTime.t(),
          upper: DateTime.t(),
          lower_inclusive: boolean(),
          upper_inclusive: boolean()
        }

  @spec new(DateTime.t(), DateTime.t(), boolean(), boolean()) :: t
  @doc ~S"""
  Create a new DateTime Range

  ## Examples

      iex> DateTime.Range.new(DateTime.from_unix!(0), DateTime.from_unix!(1))
      %DateTime.Range{
        lower: DateTime.from_unix!(0),
        lower_inclusive: true,
        upper: DateTime.from_unix!(1),
        upper_inclusive: true
      }

  """
  def new(lower, upper, lower_inclusive \\ true, upper_inclusive \\ true)

  def new(%DateTime{} = lower, %DateTime{} = upper, lower_inclusive, upper_inclusive)
      when is_boolean(lower_inclusive) and is_boolean(upper_inclusive) do
    %__MODULE__{
      lower: lower,
      upper: upper,
      lower_inclusive: lower_inclusive,
      upper_inclusive: upper_inclusive
    }
  end

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

# TODO: defimpl Inspect, for: DateTime.Range
