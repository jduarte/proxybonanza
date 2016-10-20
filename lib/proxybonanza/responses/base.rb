module Proxybonanza
  module Responses
    class Base
      require 'json'

      attr_reader :body
      def initialize(body_string)
        @body = JSON.parse(body_string)
      end
    end
  end
end
