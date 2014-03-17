class Vipbitemailer < ActionMailer::Base
	default :from => "vipBite@gmail.com"

	def InterestedPartner(name, email, address)
		@partnerName = name;
		@partnerEmail = email;
		@partnerAddress = address;

		mail to: "tam.virulhakieat@gmail.com", subject: "Interested in Paticipitation";
	end

	def ConfirmRegistration(params)
		@name = params[:firstname] << params[:lastname];
		@subscriptionType = params[:subscription] << ", " << params[:cost];
		@confirmation = params[:confirmationcode];

		mail to: params[:email], subject: "Register Confirmation";
	end

	def ConfirmRenewal(params)
		@name = params[:firstname] << params[:lastname];
		@subscriptionType = params[:subscription] << ", " << params[:cost];
		@confirmation = params[:confirmationcode];

		mail to: params[:email], subject: "Renew Confirmation";
	end

	def RecoveryEmail(params)
		@login = params[:email];
		@name = params[:firstname] << params[:lastname];
		@newpwd = params[:newpassword];

		mail to: params[:email], subject: "Password Recovery";
	end
end
