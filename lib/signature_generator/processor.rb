require 'erb'

module SignatureGenerator

  class Processor

    def initialize

    end

    def transform(template)
      ERB.new(template, nil, '-').result(context)
    end

    private

    def context
      context = SignatureGenerator::Context.new
      rendering_context = context.instance_eval do
          binding
      end
      rendering_context
    end

  end

end
