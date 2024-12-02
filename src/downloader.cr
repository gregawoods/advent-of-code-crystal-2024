require "http/client"
require "./strings"

class Downloader
  include Strings
  YEAR = 2024

  def call(number : String)
    response = HTTP::Client.get(
      "https://adventofcode.com/#{YEAR}/day/#{number}/input",
      headers: HTTP::Headers{"Cookie" => "session=#{read_session}"}
    )

    if response.status_code == 200
      File.open("inputs/#{lpad(number, "0", 2)}.txt", "w") do |file|
        file.print(response.body)
      end
    else
      raise "Failed to download input \nStatus: #{response.status}\n #{response.body}"
    end
  end

  def read_session
    raise "Could not locate .session file" unless File.exists?(".session")

    File.read(".session").strip('\n')
  end

end
