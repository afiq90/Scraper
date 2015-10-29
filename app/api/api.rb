class API < Grape::API
	prefix 'api'
	version 'v1', using: :path
	mount Articles::ArticleData
	mount Movies::MovieData
end