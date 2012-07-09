def is_equilateral?(a, b, c)
  a == b && b == c
end

def is_isosceles?(a, b, c)
  !is_equilateral?(a, b, c) && (a == b || c == b || a == c)
end

def is_scalene?(a, b, c)
  !is_isosceles?(a,b,c)
end

def is_triangle?(a, b, c)
  (a+b > c) && (a+c > b) && (b+c > a)
end

# Triangle Project Code.

# Triangle analyzes the lengths of the sides of a triangle
# (represented by a, b and c) and returns the type of triangle.
#
# It returns:
#   :equilateral  if all sides are equal
#   :isosceles    if exactly 2 sides are equal
#   :scalene      if no sides are equal
#
# The tests for this method can be found in
#   about_triangle_project.rb
# and
#   about_triangle_project_2.rb
#
def triangle(a, b, c)

  if a <= 0 || b <= 0 || c <= 0
    raise TriangleError.new "No side can be less than or equal to 0"
  end

  if !is_triangle?(a, b, c)
    raise TriangleError.new "Those sides do not form a triangle."
  end

  if is_equilateral?(a, b, c)
    return :equilateral
  elsif is_isosceles?(a,b,c)
    return :isosceles
  else
    return :scalene
  end

end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
