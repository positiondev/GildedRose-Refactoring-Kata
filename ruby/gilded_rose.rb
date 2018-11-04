class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      updater = ItemUpdater.new(item)
      item = updater.update_item
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

class ItemUpdater
  attr_accessor :item, :name, :sell_in, :quality
  def initialize(item)
    @item = item
    @name = item.name
    @sell_in = item.sell_in
    @quality = item.quality
  end

  def update_item
    update_quality

    item.quality = quality
    item.sell_in = sell_in
    item
  end

  def increase_quality
    if quality < 50
     self.quality = self.quality + 1
    end
  end

  def decrease_quality
    if quality > 0
      self.quality = self.quality - 1
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
      self.quality = 0
    end
  end

  def update_sell_in
    self.sell_in = self.sell_in - 1
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
  end
end