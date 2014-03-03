class Detail < ActiveRecord::Base
	attr_accessible :identifier, :VIPBiteDeal, :dealDetail, :reservation, :operatinghour, :link,
						:comment, :imageFolder, :urbanspoonLink, :urbanspoonReview;

	def self.AddDetail(params)
		remove = Detail.find_by(identifier: params[:identifier])
		remove.destroy if (remove != nil)

		Detail.create(
			:identifier					=> params[:identifier],
			:VIPBiteDeal				=> params[:VIPBiteDeal],
			:dealDetail					=> params[:dealdetail],
			:reservation				=> params[:reservation],
			:operatinghour			=> params[:storehour],
			:link								=> params[:link],
			:comment						=> params[:comment],
			:imageFolder				=> params[:imageFolder],
			:urbanspoonLink			=> params[:urbanspoonlink],
			:urbanspoonReview		=> params[:urbanspoonReview])
	end
end
