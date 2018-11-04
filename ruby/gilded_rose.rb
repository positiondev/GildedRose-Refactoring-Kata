class GildedRose

  def initialize(items)
    @items = items
  end

  def increase_quality(item)
    if item.quality < 50
     item.quality = item.quality + 1
    end
  end

  def decrease_quality(item)
    if item.quality > 0
      if item.name != "Sulfuras, Hand of Ragnaros"
        item.quality = item.quality - 1
      end
    end
  end

  def update_quality_of_brie(item)
    increase_quality(item)

    if item.sell_in < 0
      increase_quality(item)
    end
  end

  def update_quality_of_backstage(item)
    increase_quality(item)

    if item.sell_in < 11
      increase_quality(item)
    end
    if item.sell_in < 6
      increase_quality(item)
    end
    if item.sell_in < 0
      item.quality = 0
    end
  end

  def update_sell_in(item)
    if item.name != "Sulfuras, Hand of Ragnaros"
      item.sell_in = item.sell_in - 1
    end
  end

  def update_quality()
    @items.each do |item|
      update_sell_in(item)

      if item.name == "Aged Brie"
        update_quality_of_brie(item)
      end

      if item.name == "Backstage passes to a TAFKAL80ETC concert"
        update_quality_of_backstage(item)
      end

      if item.name !="Aged Brie" and
         item.name != "Backstage passes to a TAFKAL80ETC concert"
        decrease_quality(item)

        if item.sell_in < 0
          decrease_quality(item)
        end
      end
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end