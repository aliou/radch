# TODO: Enumerable protocol
defmodule DateTime.Range do
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
end

# TODO: defimpl Inspect, for: DateTime.Range
