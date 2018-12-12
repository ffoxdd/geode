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
    wrap_around(each_boundary_edge.first)
  end

  private def wrap_around(pivot_edge)
    new_point = maximum_angle_point(pivot_edge)
    add_to_hull(pivot_edge, new_point)
  end

  private def add_to_hull(pivot_edge, context)
    if context.free?
      add_free_point(pivot_edge, context.point)
    else
      join_to_boundary(pivot_edge, context.edge)
    end
  end

  private def add_free_point(pivot_edge, point)
    @dcel.dilate_edge(pivot_edge, point)
    @points.delete(point)
  end

  private def join_to_boundary(pivot_edge, boundary_edge)
    new_edge = @dcel.split_face(pivot_edge, boundary_edge)
    new_faces = {new_edge.face, new_edge.twin.face}
    new_faces.each { |face| check_boundary_face(face) }
  end

  private def print_state
    puts({
      vertices: @dcel.vertices.size,
      edges: @dcel.edges.size,
      faces: @dcel.faces.size,
    })
  end

  private def check_boundary_face(face)
    face.triangle? ? @boundary_faces.delete(face) : @boundary_faces.add(face)
  end

  private def maximum_angle_point(pivot_edge)
    maximum_angle_point(pivot_edge.values, each_available_point(pivot_edge))
  end

  private def maximum_angle_point(edge_points, test_points)
    max_context = shift(test_points)

    test_points.each do |test_context|
      next unless greater_angle?(edge_points, max_context.point, test_context.point)
      max_context = test_context
    end

    max_context
  end

  private def shift(iterator : Iterator(T)) forall T
    iterator.next.as(T)
  end

  private struct PointContext
    def initialize(@point : Point3, @edge : Edge(Point3)? = nil)
    end

    getter point
    getter! edge

    def free?
      @edge.nil?
    end
  end

  private def each_available_point(pivot_edge)
    each_free_point.chain(each_available_boundary_point(pivot_edge))
  end

  private def each_free_point
    @points.each.map { |point| PointContext.new(point) }
  end

  private def each_available_boundary_point(pivot_edge)
    each_non_adjacent_face_edge(pivot_edge).map do |edge|
      PointContext.new(edge.origin.value, edge)
    end
  end

  private def each_non_adjacent_face_edge(pivot_edge)
    pivot_edge.each_face_edge.reject { |edge| pivot_edge.adjacent_to?(edge.origin) }
  end

  private def each_boundary_edge
    @boundary_faces.each.flat_map(&.each_edge)
  end

  private def greater_angle?(edge_points, point, test_point)
    volume = signed_volume(*edge_points, point, test_point)

    if volume > 0
      true
    elsif volume == 0
      area(*edge_points, test_point) > area(*edge_points, point)
    else
      false
    end
  end

  private def edge_distance(edge, point)
    triangle(edge, point).signed_area
  end

  private def relative_angle(edge_points, point, test_point)
    signed_volume(*edge_points, point, test_point)
  end

  private def signed_volume(*points)
    Tetrahedron.new(points).signed_volume
  end

  private def area(*points)
    Triangle3.new(points).area
  end

  private def add_first_segment
    first_points = first_segment_points
    edge = @dcel.add_segment(first_points)

    first_points.each { |point| @points.delete(point) }
    @boundary_faces << edge.face
  end

  private def first_segment_points
    p0 = extreme_point
    support = Point3.from_coordinates({p0[0], p0[1] - 1.0, p0[2], p0[3]})

    test_points = each_free_point.reject { |context| context.point == p0 }
    p1 = maximum_angle_point({p0, support}, test_points).point

    {p0, p1}
  end

  private def extreme_point
    @points.min_by(&.coordinates)
  end

  private def closed?
    @boundary_faces.empty?
  end
end
