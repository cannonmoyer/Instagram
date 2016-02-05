class Follow < ActiveRecord::Base
	require "uri"
	require "net/http"
	require 'rubygems'
	require 'json'

	def follow
		count = 0
		Follow.each do |f|
			id = f.ig_user_id
			token = f.instagram_account.auth_token
			params = {'access_token' => token,
				  	  'action' => 'follow'
				  	}
		response = Net::HTTP.post_form(URI.parse('https://api.instagram.com/v1/users/#{id}/relationship'), params)

		parsed_response = JSON.parse(response.body)
		#z = parsed_response["access_token"]
		sleep(5)
		count += 1
		if count == 60
			break
		end

		end
		
		
	end
end
