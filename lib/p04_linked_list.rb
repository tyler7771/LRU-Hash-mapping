require 'byebug'

class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    node = first
    until node.nil?
      return node.val if node.key == key
      node = node.next
    end
    nil
  end

  def include?(key)
    node = first
    until node.nil?
      return true if node.key == key
      node = node.next
    end
    false
  end

  def insert(key, val)
    if include?(key)
      node = first
      until node.key == key
        node.next
      end
      node.val = val
    else
      new_node = Link.new(key, val)
      last.next = new_node
      new_node.prev = last
      new_node.next = @tail
      @tail.prev = new_node
    end
  end

  def remove(key)
    node = first
    until node.key == key || node.nil?
      node = node.next
    end
    node.prev.next = node.next
    node.next.prev = node.prev
  end

  def each
    node = first
    until node.next.nil?
      yield(node)
      node = node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end

end
