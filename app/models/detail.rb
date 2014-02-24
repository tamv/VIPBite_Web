class Detail < ActiveRecord::Base
	attr_accessible :identifier, :VPBiteDeal, :dealDetail, :reservation, :operatinghour, :link,
						:comment, :imageFolder, :urbanspoonLink, :urbanspoonReview;

	def AddDetail(params)
		remove = Detail.find_by(detailId: params[:Id])
		remove.destroy if (remove != nil)

		Detail.create(
			:identifier					=> params[:Id],
			:VIPBiteDeal				=> params[:promo_Name],
			:dealDetail					=> params[:detail],
			:reservation				=> params[:reservation],
			:operatinghour			=> params[:storehour],
			:link								=> params[:restaurantLink],
			:comment						=> params[:extracomment],
			:imageFolder				=> params[:imagesFolder],
			:urbanspoonLink			=> params[:urbanspoonlink],
			:urbanspoonReview		=> params[:reviewpercentage])
	end
end
