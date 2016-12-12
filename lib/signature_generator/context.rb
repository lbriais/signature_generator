
module SignatureGenerator

  class Context

    def initialize(hash={})
      @internal_hash = hash
    end

    def []=(key,val)
      internal_hash[key] = val
    end

    def method_missing(*args)
      method_name = args.shift
      return internal_hash[method_name] if internal_hash[method_name]
      super(method_name, *args)
    end

    private

    attr_reader :internal_hash

  end

end
