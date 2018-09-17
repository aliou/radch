defmodule Timestamp.RangeTest do
  use ExUnit.Case, async: true
  doctest Timestamp.Range

  @valid_range Timestamp.Range.new(DateTime.from_unix!(0), DateTime.from_unix!(1))

  describe "cast/1" do
    test "it casts Timestamp.Range into themeselves" do
      assert Timestamp.Range.cast(@valid_range) == {:ok, @valid_range}
    end

    test "it errors for anything else" do
      assert Timestamp.Range.cast([DateTime.from_unix!(0), DateTime.from_unix!(1)]) == :error
    end
  end

  describe "load/1" do
    test "it transforms a Postgrex.Range into Timestamp.Range" do
      db_range = %Postgrex.Range{
        lower: DateTime.from_unix!(0) |> DateTime.to_naive(),
        upper: DateTime.from_unix!(1) |> DateTime.to_naive(),
        lower_inclusive: true,
        upper_inclusive: false
      }

      assert Timestamp.Range.load(db_range) == {:ok, @valid_range}
    end

    test "it errors for anything else" do
      assert Timestamp.Range.load(10) == :error
    end
  end

  describe "dump/1" do
    test "it transforms a Timestamp.Range into Postgrex.Range" do
      db_range = %Postgrex.Range{
        lower: DateTime.from_unix!(0) |> DateTime.to_naive(),
        upper: DateTime.from_unix!(1) |> DateTime.to_naive(),
        lower_inclusive: true,
        upper_inclusive: false
      }

      assert Timestamp.Range.dump(@valid_range) == {:ok, db_range}
    end

    test "it errors for anything else" do
      assert Timestamp.Range.dump(10) == :error
    end
  end
end
