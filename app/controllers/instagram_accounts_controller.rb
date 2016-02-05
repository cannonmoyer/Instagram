class InstagramAccountsController < ApplicationController 
	require "uri"
	require "net/http"
	require 'rubygems'
	require 'json'


	def index
		@instagram_accounts = InstagramAccount.all
	end

	def to_follow
		@ids = Follow.all
	end

	def new
		@instagram_account = InstagramAccount.new
	end

	def create
		a = InstagramAccount.create(params.require(:instagram_account).permit(:username))	
		#a.follows.create!(ig_user_id: "asdfasdf")
			if a.valid?
				session[:new_ig_account] = a.id; 
				flash[:notice] = "Successfully Created Customer"
				redirect_to "https://api.instagram.com/oauth/authorize/?client_id=f2d963655e1144218d01eec7581a60d5&redirect_uri=http://localhost:3000/instagram_accounts/get_token&response_type=code&scope=likes relationships comments basic"
			
			else
				flash[:error] = "Error Creating Customer"
				#render "layouts/fail"
			end
		#redirect_to "https://api.instagram.com/oauth/authorize/?client_id=f2d963655e1144218d01eec7581a60d5&redirect_uri=http://localhost:3000/instagram/logged_in&response_type=code&scope=likes relationships comments basic"
	end
	
	def delete

	end

	def get_token
		x = params[:code]
		params = {'client_id' => 'f2d963655e1144218d01eec7581a60d5',
				  'client_secret' => '4853419fa6224096903448ec4489f286',
				  'grant_type' => 'authorization_code',
				  'redirect_uri' => 'http://localhost:3000/instagram_accounts/get_token',
				  'code' => x
				}
		response = Net::HTTP.post_form(URI.parse('https://api.instagram.com/oauth/access_token'), params)
		
		parsed_response = JSON.parse(response.body)

		a = InstagramAccount.find(session[:new_ig_account])
		a.update!(profile_picture: parsed_response["user"]["profile_picture"], auth_token: parsed_response["access_token"])

		redirect_to instagram_accounts_path
	end

	


	def get_followers
		session[:get_ig_followers] = params[:id]
	end

	def get_user_media_interactions
		#search for a user
		#Thread.new {
			a = InstagramAccount.find(session[:get_ig_followers]) #get current account from table
			u_id = search_for_user(params[:username], a.auth_token) #get the id for the given username
			@count = collect_media_likers(u_id, a.auth_token, a) #add all media likers id's to table
		#ActiveRecord::Base.connection.close
		#}
		#b = Follow.all
		#b.each do |g|
			#puts g.ig_user_id
		#end
		respond_to do |format|
			format.html {redirect_to customers_url}
			format.js {}
		end
	end

	def get_location_media
		params[:lon]
		params[:lat]

	end

	def get_location_media_interactions
		params[:lon]
		params[:lat]

	end

	def get_tag_media
		params[:tag]

	end

	def get_tag_media_interactions
		params[:tag]
	end


	def search_for_user(username, auth_token)
		#search for a user
		#a = InstagramAccount.find(session[:get_ig_followers])
		uri = URI.parse("https://api.instagram.com/v1/users/search?q=#{username}&count=1&access_token=#{auth_token}")
		response = Net::HTTP.get_response(uri)
		parsed_response = JSON.parse(response.body)
			 
		return parsed_response['data'][0]['id']
	end

	def collect_media_likers(user_id, auth_token, a)
		#get a media id
		count = 0

		#https://api.instagram.com/v1/users/{user-id}/media/recent/?access_token=ACCESS-TOKEN

		media_uri = URI.parse("https://api.instagram.com/v1/users/#{user_id}/media/recent?count=5&access_token=#{auth_token}")
		media_response = Net::HTTP.get_response(media_uri)
		#puts "adspoofinasdfinnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn"
		parsed_media_response = JSON.parse(media_response.body)
		
		r = parsed_media_response["data"]#[0]["id"].to_s #gets first user in returned list

		#puts "\n\n\n\n\n\n\n\n\n\n\n\n#{r}"  
		r.each do |s|
			likers_uri = URI.parse("https://api.instagram.com/v1/media/#{s['id']}/likes?access_token=#{auth_token}")
			likers_response = Net::HTTP.get_response(likers_uri)

			parsed_likers_response = JSON.parse(likers_response.body)
			l = parsed_likers_response["data"]
			l.each do |m|
				m["id"]
				a.follows.create!(ig_user_id: m["id"])
				count += 1
			end
			#a.follows.create!(ig_user_id: s)

		end
		return count
	end


	


end
