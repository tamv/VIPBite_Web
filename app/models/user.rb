class User < ActiveRecord::Base
	require 'bcrypt'
	require 'date'
	require 'securerandom'

	attr_accessible :userId, :userEmail, :firstname, :lastname, :password, :expDate, :isAdmin

	def Authenticate(login, pwd)
		user = User.find_by_userEmail(login);

		if(!user.nil?)
			checkPwd = BCrypt::Password.new(user.password);

			if(checkPwd == pwd)
				return user;
			else
				return nil;
			end
		else
			return nil
		end
	end

	def ResetPwd(email)
		user = User.find_by(userEmail: email);

		if(!user.nil?)
			new_pwd = SecureRandom.urlsafe_base64(7, false);
			encryptPwd = BCrypt::Password.create(new_pwd);

			user.update(password: encryptPwd);

			return new_pwd;
		end
	end

	def AddNewUser(firstname, lastname, email, pwd)
		userguid = SecureRandom.urlsafe_base64(16, false);
		encryptPwd = BCrypt::Password.create(pwd);

		self.create(:userId => userguid, useremail: => email,
								:firstname => firstname, :lastname => lastname,
								:password => encryptPwd, :isAdmin => false, :expDate => Time.now.to_date.to_s);
	end

	def DeleteUser(email)
		user = User.find_by_userEmail(email);

		if(!user.nil?)
			user.destroy;
		end
	end

	def UpdateExpDate(email, extentionType, billingAddress)
		user = User.find_by_userEmail(email);

		if(!user.nil?)
			if(extentionType == "6months")
				renew = 180.days.from_now;
				user.update(:expDate => renew);
			elsif(extentionType == "12months")
				renew = 365.days.from_now;
				user.update(:expDate => renew);
			end

			Transactions.create(
						:identifier => SecureRandom.urlsafe_base64(16, false), :userId => user.userId,
						:subscription => extentionType.to_s, :billingAddress => billingAddress);
		end
	end

	def UpdateUserInfo(id, newLogin, newPwd)
		user = User.find_by_userId(id);

		if(!user.nil?)
			encrypt = BCrypt::Password.create(newPwd); if(newPwd);

			user.userEmail = newLogin if(newLogin != nil);
			user.password = encrypt if(newPwd != nil);
			user.save;
		end
	end
end
