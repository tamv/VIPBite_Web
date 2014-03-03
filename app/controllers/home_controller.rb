class HomeController < ApplicationController
	def login
		if(request.get?)
			return
		end
		if(params[:email].empty? || params[:password].empty?)
			params[:password] = nil;
			redirect_to("/login") and return;
		else
			inputEmail	= params[:email];
			inputPwd		= params[:password];

			loginUsr = User.Authenticate(inputEmail, inputPwd)

			if(loginUsr != nil)
  			signIn(loginUsr);
				redirect_to("/myaccount") and return;
			else
				redirect_to("/register") and return;
			end
		end
	end

	def logout
	end

	def index
	end

	def termofused
	end

	private
	def signIn(user)
		cookies[:user] = {:value => user.userId, :expires => Time.now + 3600};
		return;
	end
end
