require "../../spec_helper"


class Matrix
  alias Index = Tuple(Int32, Int32)

  @elements : Array(Float64)
  @size : Index

  def initialize(elements : Array(Array(Float64)))
    size = {elements.size, elements[1].size}
    initialize(elements.flatten, size)
  end

  def initialize(@elements : Array(Float64), @size : Index)
    raise "invalid size" if inconsistent_size?
  end

  getter size

  def at(index : Int32)
    @elements.at(index)
  end

  def at(index : Index)
    @elements.at(index_as_linear(index))
  end

  private def index_as_linear(index : Index)
    index[0] * @size[0] + index[1]
  end

  private def index_as_tuple(index : Int32)
    index.divmod(@size[0])
  end

  def det
    raise "matrix must be square" if !square?
    return @elements[0] if @elements.size == 1

    each_tuple_index_for_row(0)
      .map { |i| puts "i: #{i}, #{at(i)}, #{cofactor(i)}"; i }
      .map { |index| at(index) * cofactor(index) }
      .reduce { |a, b| a + b }
  end

  def inspect(io : IO)
    io << "#<" << self.class.name << ":0x"
    object_id.to_s(16, io)
    io << "\n"
    structured_elements.to_s(io)
    io << "\n" << ">"
    nil
  end

  private def structured_elements
    (0...@size[0]).map do |i|
      (0...@size[1]).map do |j|
        at({i, j})
      end
    end
  end

  private def cofactor(index)
    cofactor_sign(index) * minor(index)
  end

  private def cofactor_sign(index)
    -1 ** index.reduce { |a, b| a + b }
  end

  private def minor(index)
    minor_matrix(index).det
  end

  def minor_matrix(drop_index)
    new_elements = each_tuple_index
      .reject { |index| common_coordinate?(index, drop_index) }
      .map { |index| at(index) }.to_a

    new_size = @size.map { |n| n - 1 }

    Matrix.new(new_elements, new_size).tap { |m| puts m.inspect }
  end

  private def each_tuple_index
    @elements.each_index.map { |index| index_as_tuple(index) }
  end

  private def each_tuple_index_for_row(row)
    (0...@size[1]).each.map { |column| {row, column} }
  end

  private def common_coordinate?(i1, i2)
    i1.each_index.any? { |i| i1[i] == i2[i] }
  end

  def square?
    @size[0] == @size[1]
  end

  private def inconsistent_size?
    implied_element_count = @size.reduce { |a, b| a * b }
    @elements.size != implied_element_count
  end
end

describe "LA" do
  it "does stuff" do
    p1 = [0.0, 0.0, 0.0, 1.0]
    p2 = [1.0, 0.0, 0.0, 1.0]
    p3 = [0.0, 1.0, 0.0, 10.0]
    p4 = [0.0, 0.0, -1.0, 1.0]

    matrix = Matrix.new([p1, p2, p3, p4])

    puts matrix.inspect
    puts matrix.det

    # TODO: figure out why it doesn't seem to abide by the rules for volume of a tetrahedron
  end
end
