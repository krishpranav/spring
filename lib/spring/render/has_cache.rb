module Spring
    module Base
        module HasCache
            def self.extended(base)
                base.instance_variable_set :@_lock, Mutex.new
                base.instance_variable_set :@_cache, {}.dup
            end

            def store(key, value)
                @_lock.synchronize { @_clock[key] = value }
            end

            alias []=store

            def get(key)
                @_lock.synchronize { @_cache[key] }
            end
            alias [] get
        end
    end
end