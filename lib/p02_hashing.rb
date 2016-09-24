require 'prime'
class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    # dup_array = self.dup
    # h = 0
    # dup_array.each_with_index do |el, i|
    #   h += (Prime.first el).last * i
    # end
    # h.hash

    self.to_s.hash
  end
end

class String
  def hash
    split_str = self.split("")
    count = 0

    split_str.each_with_index do |el, i|
      count += el.ord * (i + 1)
    end

    count.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    count = 0

    self.each do |k, v|
      str = k.to_s + v.to_s
      count += str.hash
    end

    count
  end
end
