module Movies
 class MovieData < Grape::API

 	resource :movie_data do
 		desc "return all movie data"

 		get do
 			Movie.all
 		end

 		desc "create a new movie"

 		params do 
 			requires :title, type: String
 			requires :image_url, type: String
 			requires :user_id, type: Integer
 		end

 		post do
 			Movie.create!({
 				title:params[:title],
 				image_url:params[:image_url],
 				user_id:params[:user_id],
 				synopsis:params[:synopsis],
 				rating:params[:rating],
 				genre:params[:genre],
 				director:params[:director],
 				runtime:params[:runtime],
 				release_date:params[:release_date],
 				hotness:params[:hotness]
 			})
 		end

 		desc "Update movie by id"

 		params do
 			requires :genre, type: String
 		end

 		put ':id' do
 			Movie.find(params[:id]).update({
 				genre:params[:genre],
 				director:params[:director],
 				runtime:params[:runtime],
 				rating:params[:rating],
 				hotness:params[:hotness]
 			})
 		end

 	end
 end
end