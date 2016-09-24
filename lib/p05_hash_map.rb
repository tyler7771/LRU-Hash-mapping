require_relative 'p02_hashing'
require_relative 'p04_linked_list'
require 'byebug'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[bucket(key)].include?(key)
  end

  def set(key, val)
    unless include?(key)
      resize! if @count >= num_buckets
      @count += 1
    end
    @store[bucket(key)].insert(key, val)

  end

  def get(key)
    @store[bucket(key)].get(key)
  end

  def delete(key)
    @count -= 1 if include?(key)
    @store[bucket(key)].remove(key)
  end

  def each
    idx = 0
    while idx < num_buckets
      @store[idx].each do |link|
        yield(link.key, link.val)
      end
      idx += 1
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @count = 0
    @store = Array.new(num_buckets * 2) { LinkedList.new }

    old_store.each do |list|
      list.each do |link|
        set(link.key, link.val)
      end
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    new_num = key.hash
    mod_num = new_num % num_buckets
  end
end
