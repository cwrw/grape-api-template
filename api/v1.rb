# for more versioning have a look at https://github.com/dblock/grape-on-rack-v1-inside-v2
module Template
  class V1 < Grape::API
    format :json
    version %w(v1), using: :header, vendor: 'acme', format: :json

    desc 'Returns the current API version, v1.'
    get do
      { version: 'v1' }
    end

    get 'only_in_v1' do
      { only_in_v1: true }
    end
  end
end