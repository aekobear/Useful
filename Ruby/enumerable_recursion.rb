module Enumerable

  def reach
    self.each do |item|
      if item.respond_to? :each
        item.each &Proc.new
      else
        yield item
      end
    end
  end

  def rmap
    self.map do |item|
      if item.respond_to? :map
        item.map &Proc.new
      else
        yield item
      end
    end
  end

end
