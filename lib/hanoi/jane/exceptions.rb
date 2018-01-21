module Hanoi
  module Jane
    class HanoiException < Exception
      attr_reader :text

      def initialize text
        @text = text
      end
    end

    class SearchException < HanoiException
      attr_reader :text

      def initialize text
        @text = text
      end
    end

    class MatrixException < HanoiException
      attr_reader :text

      def initialize text
        @text = text
      end
    end
  end
end
