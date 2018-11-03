require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end
  end

  describe "#increase_quality" do
    it "increases quality of item if less than 50" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).increase_quality(items[0])
      expect(items[0].quality).to eq 1
    end

    it "does nothing if 50 or more" do
      items = [Item.new("foo", 0, 80)]
      GildedRose.new(items).increase_quality(items[0])
      expect(items[0].quality).to eq 80
    end
  end

end
