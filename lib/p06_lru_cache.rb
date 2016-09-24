require_relative 'p05_hash_map'
require_relative 'p04_linked_list'
require 'byebug'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    eject! if count == @max unless @map.include?(key)
    if @map.include?(key)
      link = @map.get(key)
      # byebug
      update_link!(link)
      link.val
    else
      calc!(key)
      @store.last.val
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    @store.insert(key, @prc.call(key))
    @map.set(key, @store.last)
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
    link.prev.next = link.next
    link.next.prev = link.prev

    @store.last.next = link
    link.prev = @store.last

    @store.last.next.prev = link
    link.next = @store.last.next
  end

  def eject!
    key = @store.first.key
    @map.delete(key)
    @store.remove(key)
  end
end
