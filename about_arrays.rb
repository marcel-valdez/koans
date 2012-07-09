require File.expand_path(File.dirname(__FILE__) + '/edgecase')


class AboutArrays < EdgeCase::Koan
  def test_creating_arrays
    empty_array = Array.new
    assert_equal Array, empty_array.class
    assert_equal 0, empty_array.size
  end

  def test_array_literals
    array = Array.new
    assert_equal [], array

    array[0] = 1
    assert_equal [1], array

    array[1] = 2
    assert_equal [1, 2], array

    array << 333
    assert_equal [1, 2, 333], array
  end

  def test_accessing_array_elements
    array = [:peanut, :butter, :and, :jelly]

    assert_equal :peanut, array[0]
    assert_equal :peanut, array.first
    assert_equal :jelly, array[3]
    assert_equal :jelly, array.last
    assert_equal :jelly, array[-1]
    assert_equal :butter, array[-3]
  end

  def test_slicing_arrays
    array = [:peanut, :butter, :and, :jelly]

    assert_equal [:peanut], array[0,1]
    # 0 is the starting index
    # 2 is the length of the 'split'
    assert_equal [:peanut, :butter], array[0,2]
    assert_equal [:and, :jelly], array[2,2]
    # if the 'split length' is beyond the length of the array
    #    it slices until the last item.
    assert_equal [:and, :jelly], array[2,20]
    # If the length is 0, then an empty array is returned
    # If the index of the split is just 1 above the limit, then an empty array is returned, why? I don't know.
    assert_equal [], array[4, 0]
    # If the starting index is 1 beyond the limit of the array, then an empty array is returned
    assert_equal [], array[4,100]
    # If the starting index is 2 or more beyond the limit of the array, a nil is returneds
    assert_equal nil, array[5,0]
    # Does this mean that all arrays contains and "empty value" at the end?
    assert_equal [], array[4,1]
    assert_equal 4, array.length
    assert_equal [:peanut, :butter, :and, :jelly].concat([]), array
    assert_equal 4, [:peanut, :butter, :and, :jelly].concat([]).length
  end

  def test_arrays_and_ranges
    # Range is a separate class
    assert_equal Range, (1..5).class
    # A Range is not an Array
    assert_not_equal [1,2,3,4,5], (1..5)
    # Ranges defined with .. are right inclusive
    assert_equal [1,2,3,4,5], (1..5).to_a
    # Ranges defined with ... are right exclusive
    assert_equal [1,2,3,4], (1...5).to_a
  end

  def test_slicing_with_ranges
    array = [:peanut, :butter, :and, :jelly]

    assert_equal [:peanut, :butter, :and], array[0..2]

    assert_equal [:peanut, :butter], array[0...2]
    # The second argument is NOT a length, its an index, and the -1
    # index is in reality 1 to the right of :and, so it obtains it.
    assert_equal [:and, :jelly], array[2..-1]
    assert_equal [:and], array[2...-1]
  end

  def test_pushing_and_popping_arrays
    array = [1,2]
    array.push(:last)

    assert_equal [1,2,:last], array

    popped_value = array.pop
    # Its a LIFO list model (Last In First Out)
    assert_equal :last, popped_value
    assert_equal [1,2], array
  end

  def test_shifting_arrays
    array = [1,2]
    # unshift prepends an object to an array
    array.unshift(:first)
    # the question is, why did not they call it prepend ?

    assert_equal [:first, 1, 2], array

    shifted_value = array.shift
    assert_equal :first, shifted_value
    assert_equal [1,2], array
    # Active_Support adds more readable methods to Ruby
    require 'active_support/core_ext/array'
    array.prepend(:first)
    assert_equal [:first, 1, 2], array
  end

end
