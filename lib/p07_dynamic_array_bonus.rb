require 'byebug'

class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  include Enumerable
  attr_reader :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    i = @count + i  if i < 0
    i >= @count || i < 0 ? nil : @store[i]
  end

  def []=(i, val)
    if i >= @count
      (i + 1 - @count).times do
        push(nil)
      end
    end

    @store[i] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    # debugger
    each do |el|
      return true if el == val
    end
    false
  end

  def push(val)
    resize! if @count == @store.length
    @store[@count] = val
    @count += 1
  end

  def unshift(val)
    resize! if @count == @store.length
    idx = @count

    idx.times do
      @store[idx] = @store[idx - 1]
      idx -= 1
    end

    @store[0] = val
    @count += 1
  end

  def pop
    return nil if @count == 0

    val = @store[@count - 1]
    @store[@count - 1] = nil
    @count -= 1
    val
  end

  def shift
    return nil if @count == 0
    val = @store[0]
    (0...@count - 1).each do |idx|
      @store[idx] = @store[idx + 1]
    end
    @count -= 1
    val
  end

  def first
    @store[0]
  end

  def last
    @store[@count - 1]
  end

  def each
    (0...@store.length).each do |idx|
      yield(@store[idx]) unless @store[idx].nil?
    end
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    (0...@count).each do |idx|
      return false unless @store[idx] == other[idx]
    end
    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_array = StaticArray.new(@count * 2)
    (0...@count).each do |idx|
      new_array[idx] = @store[idx]
    end
    @store = new_array
  end
end
