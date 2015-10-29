module Articles	
	class ArticleData < Grape::API

		resource :article_data do
			desc "Return all article data"
			get do
				Article.all
			end

			desc "create a new article"
			## This takes care of parameter validation
			params do
				requires :title, type: String
				requires :author, type: String
				#requires :content, type: Text
			end

			#This takes care of creating article
			post do
				Article.create!({
					title:params[:title],
					content:params[:content],
					author:params[:author],
					user_id:params[:user_id],
					image_url:params[:image_url]
				})
			end

			desc "update article"
			# this takes care of parameter validation
			params do
				requires :image_url, type: String
			end

			put ':id' do
				Article.find(params[:id]).update({
					content:params[:content],
					image_url:params[:image_url]
				})
			end

			desc "delete article by id"
			# this takes care of parameter validation
			params do 
				requires :id, type: String
			end

			delete ':id' do
				Article.find(params[:id]).destroy!
			end


		end

	end
end