
chrome.extension.onRequest.addListener(function(request, sender, sendResponse){
	
		alert(request.data);
        sendResponse("666666666");
});