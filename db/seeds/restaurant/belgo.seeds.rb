Restaurant.NewRestaurant(
		:identifier				=> 'belgo_restaurant',
		:name							=> 'Belgo',
		:address					=> '501 - 8th Avenue SW',
		:city							=> 'Calgary',
		:province					=> 'Alberta',
		:postal						=> 'T2P1G1',
		:imageUrl					=> 'belgo.jpg',
		:email						=> 'shaun@belgo.ca',
		:phone						=> '403.265.6555',
		:vipbitedeal			=> 'Promotion Name',
		:detailId					=> 'belgo_promo',
		:search						=> 'fusion, dinner',
		:modifiedDate			=> "2010-08-01"
	)

Detail.AddDetail(
		:identifier				=> 'belgo_promo',
		:VIPBiteDeal			=> 'Promotion Name',
		:dealdetail				=> 'Promotion Detail',
		:reservation			=> 'reservation data....',
		:storehour				=> 'M, W, F @ 10am-5pm; Tu, Th @ 10-5',
		:link							=> 'http://www.belgo.ca/page/reservations/1000485',
		:comment					=> 'extra suggestion place here',
		:imageFolder			=> 'belgoimgs',
		:urbanspoonlink		=> 'urbanspoon.com',
		:urbanspoonReview	=> '17%'
	)