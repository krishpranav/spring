module Spring
    module Base
        class Err404 
            def index
                response.status = 404
                render('404') || 'Error 404, Not Found'
        end

        def requested_method
            :index
        end

        include Spring::Controller

        class Err500Ctrl
            def index
                response.status = 500
                render('500') || 'Internal Error 500'
            rescue 'Internal Error 500.'
            end
    end
end