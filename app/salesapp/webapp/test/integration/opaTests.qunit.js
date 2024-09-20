sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'com/sac/salesapp/test/integration/FirstJourney',
		'com/sac/salesapp/test/integration/pages/POsList',
		'com/sac/salesapp/test/integration/pages/POsObjectPage',
		'com/sac/salesapp/test/integration/pages/POItemsObjectPage'
    ],
    function(JourneyRunner, opaJourney, POsList, POsObjectPage, POItemsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('com/sac/salesapp') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThePOsList: POsList,
					onThePOsObjectPage: POsObjectPage,
					onThePOItemsObjectPage: POItemsObjectPage
                }
            },
            opaJourney.run
        );
    }
);