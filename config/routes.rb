VIPBiteWeb::Application.routes.draw do
	root to: 'home#index'

	match '/search',									:to	=>	'restaurant#search',	via: [:get, :post]
	match '/login',										:to	=>	'home#login',					via: [:get, :post]
	match '/logout',									:to	=>	'home#logout',				via: [:get, :post]
	match '/forgotpwd',								:to	=>	'user#recovery',			via: [:get, :post]
	match '/register',								:to	=>	'user#register',			via: [:get, :post]
	match '/termofused',							:to	=>	'home#termofused',		via: [:get, :post]
	match '/privacy',									:to	=>	'home#privacy',				via: [:get, :post]
	match '/account',									:to	=>	'user#account',				via: [:get, :post]
	match '/contactus',								:to	=>	'home#contactus',			via: [:post]
	match '/detail',									:to	=>	'restaurant#detail',	via: [:get, :post]
	match '/renew',										:to	=>	'user#renew',					via: [:get, :post]

	match '/mobile/login',						:to	=>	'mobile#login',				via: [:get, :post]
	match '/mobile/browse',						:to	=>	'mobile#browse',			via: [:get, :post]
	match '/mobile/map',							:to	=>	'mobile#map',					via: [:get, :post]
	match '/mobile/register',					:to =>	'mobile#register',		via: [:get, :post]
	match '/mobile/user',							:to =>	'mobile#user',				via: [:get, :post]
	match '/mobile/detail',						:to =>	'mobile#detail',			via: [:get, :post]
end
