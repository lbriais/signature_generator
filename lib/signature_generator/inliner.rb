require 'base64'
require 'open-uri'

module SignatureGenerator

  class Inliner

    IMG_TAG = /<img[^>]+src\s*=\s*"(https?:\/\/[^"]+\.(?:png|jpg|jpeg))"/

    attr_reader :original_content

    def initialize(content)
      @original_content = content
    end

    def inlined
      result = original_content.dup
      url_candidates = result.scan(IMG_TAG).flatten
      url_candidates.each do |url|
        content64 = load_file url
        result.gsub! url, content64
      end
      result
    end

    private

    def load_file(url)
      content = open(url) {|f| f.read }
      ext = url.gsub /^.*\.([^\.]+)\s*$/, '\1'
      content64 = Base64.strict_encode64 content
      'data:image/%s;base64,%s' % [ext, content64]
    rescue
      EasyAppHelper.logger.warn SignatureGenerator::Error, "Cannot load file '#{file}'"
    end

  end

end