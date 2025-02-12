sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'alfagroup/product/test/integration/FirstJourney',
		'alfagroup/product/test/integration/pages/ProductsList',
		'alfagroup/product/test/integration/pages/ProductsObjectPage',
		'alfagroup/product/test/integration/pages/ReviewsObjectPage'
    ],
    function(JourneyRunner, opaJourney, ProductsList, ProductsObjectPage, ReviewsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('alfagroup/product') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheProductsList: ProductsList,
					onTheProductsObjectPage: ProductsObjectPage,
					onTheReviewsObjectPage: ReviewsObjectPage
                }
            },
            opaJourney.run
        );
    }
);