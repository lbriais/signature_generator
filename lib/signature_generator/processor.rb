require 'erb'

module SignatureGenerator

  class Processor

    include EasyAppHelper
    include EasyAppHelper::Input
    MAX_RETRY = 3

    attr_reader :results, :context

    def initialize(context={})
      self.context = context
    end

    def transform(template, context = self.context)
      counters = {}
      begin
        @results = ERB.new(template, nil, '-').result(context_as_binding context)
      rescue NameError => e
        missing_var = e.name
        counters[missing_var] ||= 0
        counters[missing_var] += 1
        debug_msg = "Variable not provided: #{missing_var} (attempt ##{counters[missing_var]})"
        logger.debug debug_msg
        if counters[missing_var] > MAX_RETRY
          logger.error 'Maximum retry number exceeded. Aborting !'
          raise e
        end
        user_input = get_user_input "Please enter #{missing_var}"
        context[missing_var] = user_input unless user_input.nil? or user_input.empty?
        retry
      end
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
