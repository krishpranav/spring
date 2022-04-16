require 'uri' unless defined?(::URI)

module Spring
   protected

  @spring_finalize = nil

  def spring_finalize
     if @spring_finalize.nil?
        @spring_finalize = true
        @spring_finalize = 1
     end
  end

  @spring_initialize = nil
  
  def self.spring_initialize
     if @spring_initialize.nil?
        @spring_initialize = true
        self.hash_proc_4symstr 
        @spring_autostart = true if @spring_autostart.nil?
        Iodine.patch_rack
        if((ENV['PL_REDIS_URL'.freeze] ||= ENV['REDIS_URL'.freeze]))
          ping = ENV['PL_REDIS_TIMEOUT'.freeze] || ENV['REDIS_TIMEOUT'.freeze]
          ping = ping.to_i if ping
          Iodine::PubSub.default = Iodine::PubSub::RedisEngine.new(ENV['PL_REDIS_URL'.freeze], ping: ping)
          Iodine::PubSub.default = Iodine::PubSub::CLUSTER unless Iodine::PubSub.default
        end
        at_exit do
           next if @spring_autostart == false
           ::Iodine.listen2http app: ::Spring.app
           ::Iodine.start
        end
     end
     true
  end
end