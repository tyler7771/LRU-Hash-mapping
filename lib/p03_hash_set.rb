require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless include?(num)
      resize! if @count >= num_buckets
      @count += 1
      new_num = num.hash
      mod_num = new_num % num_buckets
      @store[mod_num] << num
    end
  end

  def remove(num)
    new_num = num.hash
    mod_num = new_num % num_buckets
    if include?(num)
      @store[mod_num].delete(num)
    end
  end

  def include?(num)
    new_num = num.hash
    mod_num = new_num % num_buckets
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
