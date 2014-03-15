class UserController < ApplicationController
	def register
		if(request.get?)
			flash[:warning] = "";
			return;
		end

		if(User.find_by(userEmail: params[:email]) != nil)
			flash[:warning] = "(Email Already Exist)";
			return;
		end

		success = User.AddNewUser(:userId => nil, 
										:userEmail	=> params[:email],
										:firstname	=> params[:firstname],
										:lastname		=> params[:lastname],
										:password		=> params[:password],
										:expDate		=> Time.now,
										:isAdmin		=> false);

		if(success != false)
			success = Transaction.PurchaseSubscription(
				:firstname		=> params[:noc_firstname],	:lastname				=> params[:noc_lastname],
				:cardno				=> params[:cardno],					:cardtype				=> params[:cardtype],
				:cvv					=> params[:cvv],						:exp_month			=> params[:exp_month],
				:exp_year			=> params[:exp_year],				:price				=> 90,
				:ipAddress		=> request.remote_ip,				:address			=> params[:address],
				:city					=> params[:city],						:province			=> params[:prov],
				:postal				=> params[:postal]);

			if (success != nil && success[:complete] == true)
				User.UpdateExpDate(params[:email], params[:memberType], (params[:address] + params[:prov] + params[:postal]));
				redirect_to(root_url) and return;
			elsif success == nil
				flash[:warning] = "(FAILURE TO VALIDATE YOUR CREDIT CARD! PLEASE TRY AGAIN)";
				User.DeleteUser(params[:email]) and return;
			else
				flash[:warning] = "(" << success[:message] << ")";
				User.DeleteUser(params[:email]) and return;
			end
		else
			flash[:warning] = "(User already exist)";
			redirect_to('/register') and return;
		end
	end

	def renew
		if(request.get?)
			return;
		end
		
		user = User.find_by(userId: cookies[:userId]);

		success = Transaction.PurchaseSubscription(
				:firstname		=> params[:noc_firstname],	:lastname				=> params[:noc_lastname],
				:cardno				=> params[:cardno],					:cardtype				=> params[:cardtype],
				:cvv					=> params[:cvv],						:exp_month			=> params[:exp_month],
				:exp_year			=> params[:exp_year],				:price				=> 90,
				:ipAddress		=> request.remote_ip,				:address			=> params[:address],
				:city					=> params[:city],						:province			=> params[:prov],
				:postal				=> params[:postal]);

		if (success != nil && success[:complete] == true)
			User.UpdateExpDate(user.userEmail, params[:memberType], (params[:address] + params[:prov] + params[:postal]));
			redirect_to(root_url) and return;
		elsif success.nil?
			flash[:warning] = "(FAILURE TO VALIDATE YOUR CREDIT CARD! PLEASE TRY AGAIN)";
			User.DeleteUser(params[:email]) and return;
		elsif (success[:complete] == false)
			flash[:warning] = "(" << success[:message] << ")";
			User.DeleteUser(params[:email]) and return;
		end
	end

	def account
		currentUser = cookies[:user];
		user = User.find_by(userId: currentUser);
		@userInfo = user;
	end

	def recovery
	end
end
