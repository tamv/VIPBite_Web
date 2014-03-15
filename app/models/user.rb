class User < ActiveRecord::Base
	require 'bcrypt'
	require 'date'
	require 'securerandom'

	attr_accessible :userId, :userEmail, :firstname, :lastname, :password, :expDate, :isAdmin

	def self.Authenticate(login, pwd)
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

		def self.AddNewUser(param)
		user = User.find_by_userEmail(param[:userEmail])

		if(user.nil?)
			if(param[:userId].nil?)
				userguid = SecureRandom.urlsafe_base64(16, false);
			else
				userguid = param[:userId];
			end

			encryptPwd = BCrypt::Password.create(param[:password]);

			User.create(:userId => userguid, :userEmail => param[:userEmail],
									:firstname => param[:firstname], :lastname => param[:lastname],
									:password => encryptPwd, :isAdmin => param[:isAdmin], :expDate => param[:expDate]);
			return true;
		else
			return false;
		end
	end

	def self.DeleteUser(email)
		user = User.find_by_userEmail(email);

		if(!user.nil?)
			user.destroy;
		end
	end

	def self.UpdateExpDate(email, extentionType, billingAddress)
		user = User.find_by_userEmail(email);

		if(!user.nil?)
			if(extentionType == "6months")
				renew = 180.days.from_now;
				user.update(:expDate => renew);
			elsif(extentionType == "12months")
				renew = 365.days.from_now;
				user.update(:expDate => renew);
			end

			Transaction.create(
						:identifier => SecureRandom.urlsafe_base64(16, false), :userId => user.userId,
						:subscription => extentionType.to_s, :billingAddress => billingAddress);
		end
	end

	def self.UpdateUserInfo(id, newLogin, newPwd)
		user = User.find_by_userId(id);

		if(!user.nil?)
			encrypt = BCrypt::Password.create(newPwd) if(newPwd != nil);
			user.userEmail = newLogin if(newLogin != nil);
			user.password = encrypt if(newPwd != nil);
			user.save;
		end
	end
end