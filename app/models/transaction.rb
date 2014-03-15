class Transaction < ActiveRecord::Base
	require 'securerandom'
	require 'active_merchant'

	attr_accessible :identifier, :userId, :subscription, :billingAddress

	def self.BillingAddress(params)
		{ :name => params[:firstname] + params[:lastname], :address1 => params[:address],
			:city => params[:city], :state => params[:province],
			:country => "CA", :zip => params[:postal]
		}
	end

	def self.PurchaseSubscription(params)
		ActiveMerchant::Billing::Base.mode = :test;

		creditCard = ActiveMerchant::Billing::CreditCard.new(
			:brand								=> params[:cardtype],
			:number								=> params[:cardno],
			:first_name						=> params[:firstname],
			:last_name						=> params[:lastname],
			:month								=> params[:exp_month],
			:year									=> params[:exp_year],
			:verification_value		=> params[:cvv]);

		billing = BillingAddress(params);

		if(creditCard.valid?)
			paypalGateWay = ActiveMerchant::Billing::PaypalGateway.new(
			:login => "vipbiteseller_api1.gmail.com",
			:password => "1379234540",
			:signature => "AjKIh-hQEeSMtF189H7EuPdDcz.5AfXyK9PEfe07f4KMyb2t0-32fx9t");

			response = paypalGateWay.authorize(params[:price], creditCard, :ip => params[:ipAddress],
				:billing_address => billing);

			if response.success?
				paypalGateWay.capture(params[:price], response.authorization);
				return {complete: response.success?};
			else
				return {conplete: response.success?, :message => response.message};
			end
		else
			return nil;
		end
	end
end
