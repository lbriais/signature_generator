require 'erb'

module SignatureGenerator

  class Processor

    include EasyAppHelper
    include EasyAppHelper::Input
    MAX_RETRY = 3

    attr_reader :results, :context
    attr_accessor :max_retry

    def initialize(context: {}, max_retry: MAX_RETRY)
      self.context = context
      self.max_retry = max_retry
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
        if counters[missing_var] > max_retry
          logger.error 'Maximum retry number exceeded. Aborting !'
          raise e
        end
        user_input = get_user_input "Please enter value for '#{missing_var}' > "
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
