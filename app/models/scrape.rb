class Scrape

	attr_accessor :title, :hotness, :image_url, :rating, :director, :genre, :release_date, :runtime, :synopsis, :failure, :content, :published_date, :author

	def scrape_new_movie(url)
		begin
			doc = Nokogiri::HTML(open(url))
			doc.css('script').remove
			self.title = doc.at("//h1[@itemprop = 'name']").text
			self.hotness = doc.at("//span[@itemprop = 'ratingValue']").text
			self.image_url = doc.at_css('#movie-image-section img')['src']
			self.rating = doc.at("//td[@itemprop = 'contentRating']").text
			self.director = doc.at("//span[@itemprop = 'name']").text
			self.genre = doc.at("//span[@itemprop = 'genre']").text
			self.release_date = doc.at("//td[@itemprop = 'datePublished']").text.to_date
			self.runtime = doc.at("//time[@itemprop = 'duration']").text
			self.synopsis = doc.css("#movieSynopsis").text.tidy_bytes

			return true
		rescue Exception => e
			self.failure = "Something went wrong with the scrape"
		end
	end


	def scrape_new_article(url)
		begin
			doc = Nokogiri::HTML(open(url))
			doc.css('script').remove
			self.title = doc.css(".featured--post-bg .post--title").text
			#self.content = doc.css(".single--content").text.tidy_bytes
			# use .children to get html tag, then use auto_html gem to display this shit.
			self.content = doc.css(".single--content").children
			self.published_date = doc.at("//time").text.to_date
			self.author = doc.at("/html/body/
				div[5]/div/div/div[2]/div"),
			self.image_url = doc.at("//img[@itemprop ='image']")['src']
			#puts self.image_url
			#puts self.content

			#vocket.at("//iframe")['src']
			#doc.at("/html/body/div[6]/div/div[1]/div/div/p[3]/img")
			return true
		rescue Exception => e
			self.failure = "Something went wrong with the scrape_new_article"
		end
	end

end