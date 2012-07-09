require File.expand_path(File.dirname(__FILE__) + '/edgecase')

class AboutArrayAssignment < EdgeCase::Koan
  def test_non_parallel_assignment
    names = ["John", "Smith"]
    assert_equal ["John", "Smith"], names
  end

  def test_parallel_assignments
    first_name, last_name = ["John", "Smith"]

    assert_equal "John", first_name
    assert_equal "Smith", last_name

    # variables can be assigned in parallel using arrays
  end

  def test_parallel_assignments_with_extra_values
    first_name, last_name = ["John", "Smith", "III"]
    assert_equal "John", first_name
    # If it has extra values, then those extra values are ignored
    assert_not_equal ["Smith", "III"], last_name
    assert_equal "Smith", last_name

  end

  def test_parallel_assignments_with_splat_operator
    first_name, *last_name = ["John", "Smith", "III"]
    assert_equal "John", first_name
    # If the splat operator is used, then an array is created with the remaining values
    assert_equal ["Smith", "III"], last_name
  end

  def test_parallel_assignments_with_too_few_variables
    first_name, last_name = ["Cher"]
    assert_equal "Cher", first_name
    # If there are too few variables, then exceding definitions will have nil value
    assert_equal nil, last_name
  end

  def test_parallel_assignments_with_subarrays
    first_name, last_name = [["Willie", "Rae"], "Johnson"]
    # Each variable is treated separately, independnt of its value
    # Parallel assignment is not recursive
    assert_equal ["Willie", "Rae"], first_name
    assert_equal "Johnson", last_name
  end

  def test_parallel_assignment_with_one_variable
    first_name, = ["John", "Smith"]
    # If you put a comma to the right of a variable, then its treated like a parallel assignment
    assert_equal "John", first_name
  end

  def test_swapping_with_parallel_assignment
    first_name = "Roy"
    last_name = "Rob"
    first_name, last_name = last_name, first_name
    # Parallel assignment can be used to switch values between variables (cool)
    assert_equal "Rob", first_name
    assert_equal "Roy", last_name
  end
end
