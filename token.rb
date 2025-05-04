require_relative "primitives.rb"
require_relative "serializer.rb"
require_relative "evaluator.rb"
require_relative "arithmetic.rb"
module Token

  class Token
    attr_reader :type 
    attr_accessor :source_text
    attr_reader :start
    attr_reader :end

    def initialize(type, source_text, start, end_index)
      @type = type
      @source_text = source_text
      @start = start
      @end = end_index
    end

    def source_text
      @source_text
    end
  end
end
