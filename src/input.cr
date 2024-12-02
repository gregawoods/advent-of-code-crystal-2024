require "./strings"

class Input
  include Strings

  def self.from_example(file)
    new(File.read("./examples/#{file}"))
  end

  def self.from_file(file)
    new(File.read("./inputs/#{file}"))
  end

  def initialize(data : String)
    @data = data.strip('\n')
  end

  def lines
    @data.split("\n")
  end

  def groups
    @data.split("\n\n").map do |chunk|
      chunk.split("\n")
    end
  end

end
