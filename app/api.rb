module Template
  class API < Grape::API
    prefix 'api'
    format :json
    mount ::Template::V1
    add_swagger_documentation api_version: 'v1'
  end
end