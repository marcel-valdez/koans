require File.expand_path(File.dirname(__FILE__) + '/edgecase')

class AboutObjects < EdgeCase::Koan
  def test_everything_is_an_object
    assert_equal true, 1.is_a?(Object)
    assert_equal true, 1.5.is_a?(Object)
    assert_equal true, "string".is_a?(Object)
    assert_equal true, nil.is_a?(Object)
    assert_equal true, Object.is_a?(Object)

    # Enlightment: Absolutely everything is an object.
  end

  def test_objects_can_be_converted_to_strings
    assert_equal "123", 123.to_s
    assert_equal "", nil.to_s
    # Enlightment: ni.to_s equals "", is there an String.empty ?
  end

  def test_objects_can_be_inspected
    assert_equal '123', 123.inspect
    # Enlightment: <Number.inspect> produces the exact "code representation"
    assert_equal 'nil', nil.inspect
  end

  def test_every_object_has_an_id
    obj = Object.new
    assert_equal Fixnum, obj.object_id.class
    # Enlightment: object's id are of Fixnum class'
  end

  def test_every_object_has_different_id
    obj = Object.new
    another_obj = Object.new
    assert_not_equal obj.object_id, another_obj.object_id
  end

  def test_some_system_objects_always_have_the_same_id
    assert_equal 0, false.object_id
    assert_equal 2, true.object_id
    assert_equal 4, nil.object_id
    # Enlightment: false is 0b, true is: 10b, nil is: 100b

  end

  def calculate_small_integer_id small_integer
    return 1 + (small_integer * 2)
  end
  def test_small_integers_have_fixed_ids
    assert_equal 1, 0.object_id # 01
    assert_equal 3, 1.object_id # 01 + 10 = 11
    assert_equal 5, 2.object_id # 11 + 10  = 101
    assert_equal 7, 3.object_id # 101 + 10  = 111
    assert_equal 201, 100.object_id # 01 << 100 ?
    assert_equal calculate_small_integer_id(200), 200.object_id # 01 << 100 ?

    # THINK ABOUT IT:
    # What pattern do the object IDs for small integers follow?
    # For each integer, 2 is added, and that is the id, so the formula is:
    # f(n) = 1 + (2 * n)
  end

  def test_clone_creates_a_different_object
    obj = Object.new
    copy = obj.clone

    assert_not_equal obj, copy
    assert_not_equal obj.object_id, copy.object_id
  end
end
