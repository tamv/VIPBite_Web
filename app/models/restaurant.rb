class Restaurant < ActiveRecord::Base
	require 'geocoder'

	attr_accessible :identifier, :name, :address, :city, :province, :postal, :imageUrl, :email, :phone,
									:VIPBiteDeal, :longitude, :latitude, :detailId, :search, :modifiedDate;

	def self.NewRestaurant(params)
		remove = Restaurant.find_by(name: params[:restaurantname]);
		remove.destroy if(remove != nil);
		
		fullAddress = params[:address] << "," << params[:city] << "," << params[:province] << "," << params[:postal];
		latlong = Geocoder.search(fullAddress);

		newRest = Restaurant.create(
			:identifier		=> params[:identifier],
			:name					=> params[:name],
			:address			=> fullAddress,
			:city					=> params[:city],
			:province			=> params[:province],
			:postal				=> params[:postal],
			:imageUrl			=> params[:imageUrl],
			:email				=> params[:email],
			:phone				=> params[:phone],
			:VIPBiteDeal	=> params[:vipbitedeal],
			:detailId			=> params[:detailId],
			:search				=> params[:search],
			:modifiedDate	=> params[:modifiedDate],
			:latitude			=> latlong[0].latitude,
			:longitude		=> latlong[0].longitude);
	end
end
