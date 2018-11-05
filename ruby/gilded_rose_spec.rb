require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end
  end
end

describe ConjuredItemUpdater do
  let(:item) { Item.new("Conjured foo", 5, 5) }
  let(:updater) { ConjuredItemUpdater.new(item) }

  describe "#update_quality" do
    it "degrades by two before sell-in date" do
      updater.update_quality
      expect(item.quality).to eq 3
    end

    it "degrades by four after sell-in date" do
      updater.item.sell_in = -1
      updater.update_quality
      expect(item.quality).to eq 1
    end
  end
end

describe ItemUpdater do
  let(:item) { Item.new("foo", 0, 5) }
  let(:updater) { ItemUpdater.new(item) }

  describe "#increase_quality" do

    it "increases quality of item if less than 50" do
      updater.increase_quality
      expect(item.quality).to eq 6
    end

    it "does nothing if 50 or more" do
      updater.item.quality = 80
      updater.increase_quality
      expect(item.quality).to eq 80
    end
  end

  describe "#decrease_quality" do
    it "decrease quality of item if greater than 0" do
      updater.decrease_quality
      expect(item.quality).to eq 4
    end

    it "does nothing if 0 or less" do
      updater.item.quality = 0
      updater.decrease_quality
      expect(item.quality).to eq 0
    end
  end

end
