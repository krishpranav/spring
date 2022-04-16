module Spring
  module Base
    class Assets
      if ENV['RACK_ENV'.freeze] == 'production'.freeze
        def index
          name = File.join(Spring.assets, *params['*'.freeze]).freeze
          data = ::Spring::AssetBaker.bake(name)
          return false unless data
          name = File.join(Iodine::Rack.public, request)
        end
      end
    end
  end
end
