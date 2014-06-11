var configurator = configurator || {
	ui : {
		showWidgetConfigDiv : function(params){
			var div = $('#widgetConfigDiv');
			div.css('display', 'block');
			div.css('top', params.clientY);
			div.css('left', params.clientX);

		},

		isWidgetConfigDivVisible : function(){
			return !$('#widgetConfigDiv').css('display') == 'none';
		},

		hideWidgetConfigDiv : function(){
			$('#widgetConfigDiv').css('display', 'none');
		},

		saveWidgetConfiguration : function(){
			var widgetId = $('#widgetSelected').val();
			var b = app.getBook(2);
			widget = {defaultTopLocation : 10,
					defaultLeftLocation : 0,
					topLocation : 0,
					leftLocation : 0,
					width : 0,
					height : 0,
					pagina : 0,
					type : null,
					url : "ssssss",
					titulo : null
						};

		}
	},

	init : function(){
		$('.enableWidgetConfiguration').click(function(event){
			configurator.ui.showWidgetConfigDiv(event);
		});		

		$('.saveWidgetConfiguration').click(function(event){
			configurator.ui.saveWidgetConfiguration();
			configurator.ui.hideWidgetConfigDiv();
		});

		$('.closeWidgetConfiguration').click(function(event){
			configurator.ui.hideWidgetConfigDiv();
		});

		
	}
};

configurator.init();