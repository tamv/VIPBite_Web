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
		if(params[:name] == nil)
			return;
		end

		overview = Restaurant.find_by(name: params[:name]);
		detail = Detail.find_by(identifier: overview.detailId);

		@name = overview.name;
		@address = [];
		@phone = overview.phone;
		@lat = overview.latitude;
		@lng = overview.longitude;
		@logo = overview.imageUrl;
		@web = detail.link;
		@reservation = detail.reservation;
		@hour = [];
		@urbanlink = detail.urbanspoonLink;
		@rate = detail.urbanspoonReview;
		@dealDetail = detail.dealDetail;
		@image = [];
		@lat = overview.latitude;
		@lon = overview.longitude;

		@address.push(overview.address.split(",")[0]);
		@address.push("" << overview.city << ", " << overview.province);
		@address.push(overview.postal);

		detail.operatinghour.split(";").each do |h|
			@hour.push(h);
		end

		Dir.glob('/image/restaurant detail/' << "belgoimgs" << '/*').each do |file|
			@image.push("/" << file.split('/')[1..-1].join('/'))
		end
	end
end
