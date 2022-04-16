module Spring
  module Base
     class Assets
        if ENV['RACK_ENV'.freeze] == 'production'.freeze
           def index
              name = File.join(Spring.assets, *params['*'.freeze]).freeze
              data = ::Spring::AssetBaker.bake(name)
              return false unless data
              name = File.join(Iodine::Rack.public, request.path_info[1..-1]).freeze if Iodine::Rack.public
              if data.is_a?(String)
                 FileUtils.mkpath File.dirname(name)
                 IO.binwrite(name, data)
              end
              response['X-Sendfile'.freeze] = name
              response.body = File.open(name)
              true
           end
        else
           def index
              name = File.join(Spring.assets, *params['*'.freeze]).freeze
              data = ::Spring::AssetBaker.bake(name)
              return data if data.is_a?(String)
              false
           end
        end

        def show
           index
        end
     end
  end

  module AssetBaker
     @drivers = {}
     def self.register(ext, driver)
        (@drivers[".#{ext}".freeze] ||= [].to_set) << driver
     end

     def self.bake(name)
        ret = nil
        ext = File.extname name
        return false if ext.empty?
        driver = @drivers[ext]
        return false if driver.nil?
        driver.each { |d| ret = d.call(name); return ret if ret }
        nil
     end
  end
end

require 'spring/render/sassc.rb'
require 'spring/render/sass.rb'