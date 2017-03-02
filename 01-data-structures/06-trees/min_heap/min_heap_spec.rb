include RSpec

require_relative 'min_heap'

RSpec.describe MinHeap, type: Class do
  let (:root) { Node.new("The Matrix", 87) }

  let (:heap) { MinHeap.new(root) }
  let (:pacific_rim) { Node.new("Pacific Rim", 72) }
  let (:braveheart) { Node.new("Braveheart", 78) }
  let (:jedi) { Node.new("Star Wars: Return of the Jedi", 80) }
  let (:donnie) { Node.new("Donnie Darko", 85) }
  let (:inception) { Node.new("Inception", 86) }
  let (:district) { Node.new("District 9", 90) }
  let (:shawshank) { Node.new("The Shawshank Redemption", 91) }
  let (:martian) { Node.new("The Martian", 92) }
  let (:hope) { Node.new("Star Wars: A New Hope", 93) }
  let (:empire) { Node.new("Star Wars: The Empire Strikes Back", 94) }
  let (:mad_max_2) { Node.new("Mad Max 2: The Road Warrior", 98) }

  describe "#initialize data" do
    it "adds the argument as a root instance variable" do
      expect(heap.root).to eq(root)
    end
  end

  describe "#insert data" do
    it "adds a movie with a higher score as left child of root" do
      heap.insert(root, hope)
      expect(heap.root.left).to eq(hope)
    end

    it "fills in a level with 2 movies before going to the third level" do
      heap.insert(root, hope)
      heap.insert(root, martian)
      expect(heap.root.left).to eq(hope)
      expect(heap.root.right).to eq(martian)
    end

    it "adds data as the left-most child when moving to a new level" do
      heap.insert(root, hope)
      heap.insert(root, martian)
      heap.insert(root, empire)
      expect(heap.root.left.left).to eq(empire)
    end

    it "swaps the root node when a movie with a lower rating is inserted" do
      heap.insert(root, jedi)
      expect(heap.root.title).to eq("Star Wars: Return of the Jedi")
      expect(heap.root.left.title).to eq("The Matrix")
    end

    it "swaps an 'arbitrary' node when one of a lower rating is inserted" do
      heap.insert(root, hope)
      heap.insert(root, martian)
      heap.insert(root, empire)
      heap.insert(root, mad_max_2)
      heap.insert(root, shawshank)

      expect(root.right.title).to eq("The Shawshank Redemption")
      expect(root.right.left.title).to eq("The Martian")
    end

  end

  describe "#find data" do
    it "finds the node with the given title" do

      heap.insert(root, hope)
      heap.insert(root, martian)
      heap.insert(root, empire)
      heap.insert(root, mad_max_2)
      heap.insert(root, shawshank)

      expect(heap.find(root, "The Martian").title).to eq ("The Martian")
    end
  end

  describe "#delete data" do
    it "deletes the node with the given title" do
      heap.insert(root, hope)
      heap.insert(root, martian)
      heap.insert(root, empire)

      heap.delete(root, "Star Wars: A New Hope")
      expect(root.left.title).to eq("Star Wars: The Empire Strikes Back")
    end
  end

  describe "#print" do
     specify {
       expected_output = "The Matrix: 87\nStar Wars: A New Hope: 93\nThe Shawshank Redemption: 91\nStar Wars: The Empire Strikes Back: 94\nMad Max 2: The Road Warrior: 98\nThe Martian: 92\n"
       heap.insert(root, hope)
       heap.insert(root, martian)
       heap.insert(root, empire)
       heap.insert(root, mad_max_2)
       heap.insert(root, shawshank)
       expect { heap.print }.to output(expected_output).to_stdout
     }

  end

end
