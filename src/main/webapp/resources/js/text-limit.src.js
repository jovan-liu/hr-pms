jQuery.fn.textlimit=function(counter_el, thelimit, speed) {
	var charDelSpeed = speed || 15;
	var toggleCharDel = speed != -1;
	var toggleTrim = true;
	var timer = null;
	var that = this[0];
	updateCounter();
	
	function updateCounter(){
		jQuery(counter_el).text(thelimit - that.value.length);
	};
	
	this.keypress (function(e){ 
		if ($.browser.opera) {
			//opera无charcode，backspace：keycode=8
			if( doublecharLength(this.value) >= thelimit && e.keyCode != '8' ) e.preventDefault()
		}
		else{
			if( this.value.length >= thelimit && e.charCode != '0' ) e.preventDefault() 
		}
	})
	.keyup (function(e){
		updateCounter();
		if( this.value.length >= thelimit && toggleTrim ){
			if(toggleCharDel){
				// first, trim the text a bit so the char trimming won't take forever
				that.value = that.value.substr(0,thelimit+100);
				var init = setInterval
					( 
						function(){ 
							if( that.value.length <= thelimit){ init = clearInterval(init); updateCounter() }
							else{ that.value = that.value.substring(0,that.value.length-1); 
							jQuery(counter_el).text('loading...'+(thelimit - that.value.length)); 
							};
						} ,charDelSpeed 
					);
			}
			else this.value = that.value.substr(0,thelimit);
		}
	});
	//解决ipera下输入中文计数器没有反应的bug
	if($.browser.opera){
		this.bind("focus",function(e) {
			//中文需要轮询查
			this.timer = setInterval(function(){
				updateCounter();
			},500)
		});
		//失去焦点时取消定时器
		this.bind("blur",function(e) {
			clearInterval(this.timer);
			this.time = null;
		}); 
	}
	
};