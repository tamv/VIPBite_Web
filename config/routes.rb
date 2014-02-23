VIPBiteWeb::Application.routes.draw do
	root to: 'home#index'

	match '/search',				:to	=>	'restaurant#search',	via: [:get, :post]

	match '/mobile/login',						:to	=>	'mobile#login',				via: [:get, :post]
	match '/mobile/browse',						:to	=>	'mobile#browse',			via: [:get, :post]
	match '/mobile/map',							:to	=>	'mobile#map',					via: [:get, :post]
	match '/mobile/register',					:to =>	'mobile#register',		via: [:get, :post]
	match '/mobile/user',							:to =>	'mobile#user',				via: [:get, :post]
	match '/mobile/detail',						:to =>	'mobile#detail',			via: [:get, :post]
end
