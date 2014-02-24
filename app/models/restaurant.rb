class Restaurant < ActiveRecord::Base
	require 'geocoder'

	attr_accessible :identifier, :name. :address, :city, :province, :postal, :imageUrl, :email,
							:phone, :VIPBiteDeal, :longitude, :latitude, :detailId, :search, :modifiedDate;

	def NewRestaurant(params)
		remove = Restaurant.find_by(name: params[:restaurantname]);
		remove.destroy if(remove != nil);
		
		fullAddress = params[:address] << "," << params[:city] << "," << params[:province] << "," << params[:postal];
		latlong = Geocoder.search(fullAddress);

		newRest = Restaurant.create(
			:name					=> params[:restaurantname],
			:address			=> fullAddress,
			:city					=> params[:city],
			:province			=> params[:province],
			:postal				=> params[:postal],
			:imageUrl			=> params[:imageUrl],
			:email				=> params[:email],
			:phone				=> pramas[:phone],
			:VIPBiteDeal	=> params[:dealName],
			:latitude			=> latlong[0].latitude,
			:longiture		=> latlong[0].longitude,
			:detailId			=> params[:detailId],
			:search				=> params[:tags],
			:modifiedDate	=> params[:dateInsert]);
	end
end
