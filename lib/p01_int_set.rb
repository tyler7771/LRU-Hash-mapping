class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(@max) { false }
  end

  def insert(num)
    if num >= @max || num < 0
      raise "Out of bounds"
    else
      @store[num] = true
    end
  end

  def remove(num)
    if num >= @max || num < 0
      raise "Out of bounds"
    else
      @store[num] = false
    end
  end

  def include?(num)
    if num >= @max || num < 0
      raise "Out of bounds"
    else
      return @store[num]
    end
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    mod_num = num % 20
    @store[mod_num] << num unless include?(num)
  end

  def remove(num)
    mod_num = num % 20
    if include?(num)
      @store[mod_num].delete(num)
    end
  end

  def include?(num)
    mod_num = num % 20
    @store[mod_num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless include?(num)
      resize! if @count >= num_buckets
      @count += 1
      mod_num = num % num_buckets
      @store[mod_num] << num
    end
  end

  def remove(num)
    mod_num = num % num_buckets
    if include?(num)
      @store[mod_num].delete(num)
    end
  end

  def include?(num)
    mod_num = num % num_buckets
    @store[mod_num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @count = 0
    @store = Array.new(num_buckets * 2) { Array.new }

    old_store.flatten.each { |num| insert(num) }
  end
end
