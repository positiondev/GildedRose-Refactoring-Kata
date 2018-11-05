class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      updater = ItemUpdaterFactory.create_updater_for(item)
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

class ItemUpdaterFactory
  def self.create_updater_for(item)
    { "Sulfuras, Hand of Ragnaros" => LegendaryItemUpdater.new(item),
      "Aged Brie" => AgedBrieItemUpdater.new(item),
      "Backstage passes to a TAFKAL80ETC concert" =>
        BackstagePassesItemUpdater.new(item),
      "Conjured" => ConjuredItemUpdater.new(item)
    }.fetch(lookup_name(item), ItemUpdater.new(item))
  end

  def self.lookup_name(item)
    if item.name.include?("Conjured")
      "Conjured"
    else
      item.name
    end
  end
end

module Updaterable
  attr_accessor :item

  def initialize (item)
    @item = item
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

  def update_sell_in
    item.sell_in = item.sell_in - 1
  end

  def update_item
    update_sell_in

    update_quality

    item
  end
end

class ItemUpdater
  include Updaterable
  attr_reader :name

  def update_quality
    decrease_quality

    if sell_in < 0
      decrease_quality
    end
  end
end

class LegendaryItemUpdater
  include Updaterable

  def update_sell_in
  end

  def update_quality
  end
end

class AgedBrieItemUpdater
  include Updaterable

  def update_quality
    increase_quality

    if sell_in < 0
      increase_quality
    end
  end
end

class BackstagePassesItemUpdater
  include Updaterable

  def update_quality
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
end

class ConjuredItemUpdater
  include Updaterable

  def update_quality
    2.times { decrease_quality }

    if sell_in < 0
      2.times { decrease_quality }
    end
  end
end