class InstagramController < ApplicationController
	require "uri"
	require "net/http"
	require 'rubygems'
	require 'json'
def search(username, auth_token)
		#search for a user
		a = InstagramAccount.find(session[:get_ig_followers])

		uri = URI.parse("https://api.instagram.com/v1/users/search?q=#{username}&count=1&access_token=#{auth_token}")
		response = Net::HTTP.get_response(uri)

		parsed_response = JSON.parse(response.body)
		 
		return parsed_response['data'][0]['id']

	end

	def authorize
		redirect_to "https://api.instagram.com/oauth/authorize/?client_id=f2d963655e1144218d01eec7581a60d5&redirect_uri=http://localhost:3000/instagram/logged_in&response_type=code&scope=likes relationships comments basic"
	end

	def get_token
		x = params[:code]

		params = {'client_id' => 'f2d963655e1144218d01eec7581a60d5',
				  'client_secret' => '4853419fa6224096903448ec4489f286',
				  'grant_type' => 'authorization_code',
				  'redirect_uri' => 'http://localhost:3000/instagram/logged_in',
				  'code' => x
				}
		response = Net::HTTP.post_form(URI.parse('https://api.instagram.com/oauth/access_token'), params)
		#
		#https://api.instagram.com/v1/users/{user-id}/relationship?access_token=ACCESS-TOKEN

		parsed_response = JSON.parse(response.body)

		z = parsed_response["access_token"]
		#end login need to save access token to db

		#search for a user
		uri = URI.parse("https://api.instagram.com/v1/users/search?q=justinbieber&access_token=#{z}")
		response = Net::HTTP.get_response(uri)

		parsed_response = JSON.parse(response.body)

		parsed_response["data"][0]["username"] #gets first user in returned list
		#puts "\n\n\n\n\n\n\n\n\n\n\n\n#{parsed_response["data"][0]["id"]}"  
		users = {
			"profile_picture" => parsed_response["data"][0]["profile_picture"],
    		"Username" => "jusinbieber",
    		"id" => "lololololol"
  		}
  		@array = []
  		@array.push(users)


		#get a media id

		#https://api.instagram.com/v1/users/{user-id}/media/recent/?access_token=ACCESS-TOKEN

		uri = URI.parse("https://api.instagram.com/v1/users/#{parsed_response["data"][0]["id"]}/media/recent?access_token=#{z}")
		response = Net::HTTP.get_response(uri)

		parsed_response = JSON.parse(response.body)

		r = parsed_response["data"][0]["id"].to_s #gets first user in returned list
		#puts "\n\n\n\n\n\n\n\n\n\n\n\n#{r}"  


		#get list of likers of media

		#https://api.instagram.com/v1/media/{media-id}/likes?access_token=ACCESS-TOKEN

		uri = URI.parse("https://api.instagram.com/v1/media/#{parsed_response["data"][0]["id"]}/likes?access_token=#{z}")
		response = Net::HTTP.get_response(uri)

		parsed_response = JSON.parse(response.body)

		r = parsed_response["data"] #gets first user in returned list

		r.each do |s|
			puts s["id"]
		end
		##puts "\n\n\n\n\n\n\n\n\n\n\n\n#{r}"  

	end


	def search

	end

	

end
