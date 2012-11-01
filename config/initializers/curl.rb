    class Curl::Easy
      def parsed
        JSON.parse(self.body_str)
      end
    end
