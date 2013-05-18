 console.log(-1);
 $(document).ready(
 	function()
 	{		
		var rand = Math.random().toString();
		localStorage['rand'] = localStorage['rand'] || rand;
		
		var code = localStorage['rand'];
		
		jQuery(
		function(){
			jQuery('#output').qrcode({width: 128,height: 128,text: code});
		}
		);
       
	    chrome.tabs.getSelected(null, function(tab) {
            chrome.tabs.sendRequest(tab.id, {data: code, id: tab.id}, function(response)
			{
                alert(reponse.status);
            });
			   });
    });

