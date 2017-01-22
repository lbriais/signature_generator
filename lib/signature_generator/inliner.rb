module SignatureGenerator

  class Inliner

    attr_reader :original_content

    def initialize(content)
      @original_content = content
    end

    def inlined
      content.gsub /<img[^>]+src="https?:\/\/[^"]+\.(png|jpg|jpeg)"/
    end

  end

end