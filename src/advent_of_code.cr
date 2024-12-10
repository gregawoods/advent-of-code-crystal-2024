require "option_parser"
require "./downloader"
require "./runner"

module AdventOfCode
  VERSION = "0.1.0"
end

OptionParser.parse do |parser|
  parser.banner = "Advent of Code 2024"

  parser.on "-d DAY", "--download=DAY", "Download input" do |day|
    puts "You are downloading day #{day} input"
    downloader = Downloader.new
    downloader.call(day)
    exit
  end

  parser.on "-s DAY", "--solve=DAY", "Solve a day" do |day|
    runner = Runner.new
    runner.call(day)
    exit
  end

  parser.on "solve", "Solve all days" do
    runner = Runner.new
    runner.solve_all
    exit
  end

  parser.on("-h", "--help", "Show this help") do
    puts parser
    exit
  end
end
