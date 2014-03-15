class RestaurantController < ApplicationController
	def search
		if(request.get?)
			@searchResult = Restaurant.order(modifiedDate: :desc).take(5);
		elsif(request.post?)
			search = "%" << params[:search] << "%";
			
			@searchResult = Restaurant.where('name ILIKE ? OR search ILIKE ?', search, search);
		end
	end

	def detail
	end
end
