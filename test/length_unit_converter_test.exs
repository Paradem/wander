defmodule Wander.LengthUnitConverterTest do
  use Wander.ModelCase

  import Wander.LengthUnitConverter

  test "direct conversion" do
    assert convert({1, :km}, :m) == {1000, :m}
    assert convert({1000, :m}, :km) == {1, :km}
    assert convert({1, :mi}, :m) == {1609.344, :m}
    assert convert({1609.344, :m}, :mi) == {1, :mi}
  end

  test "indirect conversion" do
    assert convert({1, :mi}, :km) == {1.609344, :km}
  end
end
