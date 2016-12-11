require 'erb'

module SignatureGenerator

  class Processor

    include EasyAppHelper::Input

    attr_reader :results, :context

    def initialize(context={})
      self.context = context
    end

    def transform(template, context = self.context)
      @results = ERB.new(template, nil, '-').result(context_as_binding context)
    end

    def context=(context)
      raise SignatureGenerator::Error, 'Context cannot be nil' if context.nil?
      @context = case context
                   when Hash
                     SignatureGenerator::Context.new context
                   when SignatureGenerator::Context
                     context
                 end
    end

    private

    def context_as_binding(context)
      context.instance_eval do
        binding
      end
    end

  end

end
