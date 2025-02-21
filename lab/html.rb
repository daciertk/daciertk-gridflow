module Html
    def self.make_tag(element, attributes, type)
      tag = "<#{element}"
      attributes.each do |key,value|
        tag += " #{key}=#{value}"
      end
      if type == :empty
        tag += ">"
      elsif type == :sandwich
        tag += "></#{element}>"
      elsif type == :selfclose
        tag += "/>"
      else 
        puts "Invalid symbol"
      end
      tag
    end
  
end
