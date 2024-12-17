require "./spec_helper"

describe Day17 do
  day = Day17.new
  input = Input.from_example("17.txt")

  describe "perform_operation" do
    it "performs operation 2" do
      day.register_c = 9
      day.perform_operation(2, 6)
      day.register_b.should eq(1)
    end

    it "performs a series of operations" do
      program = <<-STRING
      Register A: 10
      Register B: 0
      Register C: 0

      Program: 5,0,5,1,5,4
      STRING

      day.part1(Input.new(program))
      day.output.should eq([0,1,2])
    end

    it "performs a series of operations" do
      program = <<-STRING
      Register A: 2024
      Register B: 0
      Register C: 0

      Program: 0,1,5,4,3,0
      STRING

      day.part1(Input.new(program))
      day.output.should eq([4,2,5,6,7,7,7,7,3,1,0])
      day.register_a.should eq(0)
    end

    it "performs a series of operations" do
      program = <<-STRING
      Register A: 0
      Register B: 29
      Register C: 0

      Program: 1,7
      STRING

      day.part1(Input.new(program))
      day.register_b.should eq(26)
    end
  end

  describe "part1" do
    it "works" do
      day.part1(input).should eq("4,6,3,5,6,3,5,2,1,0")
    end
  end

  describe "part2" do
    it "works" do
      day.part2(input).should eq(0)
    end
  end

end
