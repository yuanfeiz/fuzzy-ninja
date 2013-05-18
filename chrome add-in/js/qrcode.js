 console.log(-1);
 $(document).ready(
 	function()
 	{
 		console.log(0);
        chrome.tabs.getSelected(null, 
        	function(tab) {
            	chrome.tabs.sendRequest(tab.id,function(response){
            			console.log(1);
                		jQuery(function(){
							Query('#output').qrcode({width: 128,height: 128,text: "Size doesn't matter"});
						});
                	});
                //$('#output').html("");
                //$('#output').html(response.flag);
            });
    });

