class Transaction < ActiveRecord::Base
	require 'securerandom'
	require 'active_merchant'

	attr_accessible :identifier, :userId, :subscription, :billingAddress

	def BillingAddress(params)
		{ :name => params[:firstname] + params[:lastname], :address1 => params[:address],
			:city => params[:city], :state => params[:province],
			:country => "CA", :zip => params[:postal]
		}
	end

	def PurchaseSubscription(params)
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
			response = GATEWAY.purchase(params[:price], creditCard, :ip => params[:ipAddress],
				:billing_address => billing);

			return {conplete: response.success?, :message => response.message};
		else
			return nil;
		end
	end
end
