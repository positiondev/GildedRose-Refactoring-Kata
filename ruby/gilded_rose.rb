class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      updater = ItemUpdater.new(item)
      item = updater.update_quality
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

# ItemUpdater and Item are very coupled?
# Maybe okay since the rules force us...
class ItemUpdater
  attr_accessor :item
  attr_reader :name

  def initialize(item)
    @item = item
    @name = item.name
  end

  def sell_in
    item.sell_in
  end

  def quality
    item.quality
  end

  def increase_quality
    if quality < 50
     item.quality = item.quality + 1
    end
  end

  def decrease_quality
    if quality > 0
      item.quality = item.quality - 1
    end
  end

  def update_quality_of_brie
    increase_quality

    if sell_in < 0
      increase_quality
    end
  end

  def update_quality_of_backstage
    increase_quality

    if sell_in < 11
      increase_quality
    end
    if sell_in < 6
      increase_quality
    end
    if sell_in < 0
      item.quality = 0
    end
  end

  def update_sell_in
    item.sell_in = item.sell_in - 1
  end

  def update_quality
    if name == "Sulfuras, Hand of Ragnaros"
      return
    end

    update_sell_in

    if name == "Aged Brie"
      update_quality_of_brie
    end

    if name == "Backstage passes to a TAFKAL80ETC concert"
      update_quality_of_backstage
    end

    if name !="Aged Brie" and
        name != "Backstage passes to a TAFKAL80ETC concert"
      decrease_quality

      if sell_in < 0
        decrease_quality
      end
    end

    item
  end
end