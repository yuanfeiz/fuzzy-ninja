 console.log(-1);
 $(document).ready(
 	function()
 	{		
		var rand = Math.random().toString();
		localStorage['rand'] = localStorage['rand'] || rand;
		
		var code = localStorage['rand'];
		code = 88888;
		jQuery(
		function(){
			jQuery('#output').qrcode({border: "5px",width: 128,height: 128,text: code.toString()});
		}
		);
       
	    chrome.tabs.getSelected(null, function(tab) {
            chrome.tabs.sendRequest(tab.id, {data: code, id: tab.id}, function(response)
			{
                alert(reponse.status);
            });
			   });
    });

