class MobileController < ApplicationController

	respond_to :JSON

	def login
		userName = params[:username];
		password = params[:password];

		if(userName.nil? || password.nil?)
			render :json => {respond: nil}.to_json, :callback => params[:callback];
		else
			loginUser = Users.Authenticate(userName, password)

			if(loginUser.nil?)
				render :json => {respond: nil}.to_json, :callback => params[:callback];
			else
				render :json => {respond: loginUser}.to_json, :callback => params[:callback];
			end
		end
	end

	def browse
		browseBy = params[:browseby];
		
		if(browseBy.nil?)
			render :json => {response: nil}.to_json, :callback => params[:callback] and return;
		end
		
		search = "%" << browseBy << "%"
		@searchRestaurant = Restaurants.where('restaurantname ILIKE ? OR tags ILIKE ?', search, search);

		if(0 != @searchRestaurant.count)
			render	:json => 
							{
								response: @searchRestaurant, 
								originalUri: request.protocol + request.host_with_port + "/Image/"
							}.to_json,
							:callback => params[:callback] and return;
		else
			render :json => {response: nil}.to_json, :callback => params[:callback] and return;
		end
	end

	def detail
		restaurant = params[:restaurantName];

		if(restaurant.nil?)
			render :json => { response: nil }.to_json, :callback => params[:callback] and return;
		end

		rest_overView = Restaurants.find_by(restaurantname: restaurant);

		if(rest_overView.nil?)
			render :json => { response: nil }.to_json, :callback => params[:callback] and return;
		end

		rest_info = Details.find_by(detailId: rest_overView.detailId);

		if(rest_info.nil?)
			render :json => { response: nil }.to_json, :callback => params[:callback] and return;
		end

		@Images = []

		Dir.glob("public/Image/restaurant/" << rest_info.imgFolder << "/*").each do |file|
				@Images.push("/" << file.split('/')[2..-1].join('/'))
		end

		render 	:json => 
						{
							response: "found",
							overview: rest_overView,
							info: rest_info,
							images: @Images
						}.to_json,
						:callback => params[:callback];
	end

	def map
		maxlat = params[:latitudeMax];
		minlat = params[:latitudeMin];
		maxlng = params[:longitudeMax];
		minlng = params[:longitudeMin];

		@searchRestaurant = Restaurants.where(
			'latitude > ? AND latitude < ? AND longitude > ? AND longitude < ?',
			minlat, maxlat, minlng, maxlng);

		render :json => 
						{
							response: @searchRestaurant,
							originalUri: request.protocol + request.host_with_port + "/Image/"
						}.to_json,
						:callback => params[:callback] and return;
	end

	def register
	end

	def user
		if(request.get? && cookies[:user] == nil)
			redirect_to root_url and return;
		else
			@loginUser = Users.find_by(userId: cookies[:user]);
		end
	end
end
