class Geo::ConvexHull::GiftWrap
  def initialize(points)
    raise ArgumentError.new("must supply at least 3 points") if points.size < 3

    @points = Set(Point3).new(points)
    @boundary_faces = Set(Face(Point3)).new
    @dcel = DCEL(Point3).new
  end

  delegate empty?, to: @dcel

  def hull
    calculate
    @dcel
  end

  private def calculate
    return if !empty?
    add_first_segment

    until closed?
      wrap
    end
  end

  private def wrap
    wrap_around(boundary_edges.first)
  end

  private def wrap_around(edge)
    add_to_hull(edge, point_with_maximum_angle(edge))
  end

  private def add_to_hull(edge, point)
    @dcel.extend_triangle(edge, point)
  end

  private def point_with_maximum_angle(edge)
    available_points = @points.each
    max_point = available_points.next.as(Point3)

    available_points.each do |test_point|
      max_point = test_point if greater_angle?(edge, max_point, test_point)
    end

    max_point
  end

  private def greater_angle?(edge, current_point, test_point)
    angle = relative_angle(edge, current_point, test_point)
    angle > 0 #|| (angle == 0 && closer?(edge, current_point, test_point))
  end

  # private def closer?(edge, current_point, test_point)
  #   edge_distance(edge, test_point) < edge_distance(edge, current_point)
  # end

  # private def edge_distance(edge, point)
  #   triangle(edge, point).signed_area
  # end

  private def relative_angle(edge, current_point, test_point)
    tetrahedron(edge, current_point, test_point).signed_volume
  end

  private def tetrahedron(edge, current_point, test_point)
    Tetrahedron.new({edge.origin.value, edge.target.value, current_point, test_point})
  end

  # private def triangle(edge, point)
  #   Triangle.new({edge.origin.value, edge.target.value, point})
  # end

  private def boundary_edges
    @boundary_faces.each.flat_map(&.each_edge)
  end

  private def add_first_segment
    first_points = first_segment_points
    edge = @dcel.add_segment(first_points)

    first_points.each { |point| @points.delete(point) }
    @boundary_faces << edge.face
  end

  private def first_segment_points
    Tuple(Point3, Point3).from(@points.first(2))
  end

  @@closed_calls = 0 # safety during testing
  private def closed?
    @boundary_faces.empty?.tap do
      @@closed_calls += 1
      raise "infinite loop "if @@closed_calls > 1
    end
  end
end
