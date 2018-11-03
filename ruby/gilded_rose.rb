class GildedRose

  def initialize(items)
    @items = items
  end

  def increase_quality(item)
    if item.quality < 50
     item.quality = item.quality + 1
    end
  end

  def update_quality_of_non_brie_non_backstage(item)
    if item.quality > 0
      if item.name != "Sulfuras, Hand of Ragnaros"
        item.quality = item.quality - 1
      end
    end
  end

  def update_quality_of_brie_and_backstage(item)
    increase_quality(item)
    if item.name == "Backstage passes to a TAFKAL80ETC concert"
      update_quality_of_backstage(item)
    end
  end

  def update_quality_of_backstage(item)
    if item.sell_in < 11
      increase_quality(item)
    end
    if item.sell_in < 6
      increase_quality(item)
    end
  end

  def update_quality_when_sell_in_less_than_zero(item)
    if item.name != "Aged Brie"
      if item.name != "Backstage passes to a TAFKAL80ETC concert"
        if item.quality > 0
          if item.name != "Sulfuras, Hand of Ragnaros"
            item.quality = item.quality - 1
          end
        end
      else
        item.quality = item.quality - item.quality
      end
    else
      increase_quality(item)
    end
  end

  def update_sell_in(item)
    if item.name != "Sulfuras, Hand of Ragnaros"
      item.sell_in = item.sell_in - 1
    end
  end

  def update_quality()
    @items.each do |item|
      if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
        update_quality_of_non_brie_non_backstage(item)
      else
        update_quality_of_brie_and_backstage(item)
      end

      update_sell_in(item)

      if item.sell_in < 0
        update_quality_when_sell_in_less_than_zero(item)
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