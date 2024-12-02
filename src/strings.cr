module Strings
  def lpad(source : String, char : String, len : Int32)
    new_str = source

    while new_str.size < len
      new_str = char + new_str
    end

    return new_str
  end
end
