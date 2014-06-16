//= require jquery
//= require jquery_ujs
(function(){
	window.widgets = window.widgets || {
		elements : [],

		add : function(id){
			var div = document.getElementById(id);
			var widget = {
				"defaultTopLocation": div.style.top,
				"defaultLeftLocation":div.style.marginLeft,
				"topLocation":0,
				"leftLocation":0,
				"width" : div.style.width,
				"height": div.style.width,
				"pagina": window.paginaAtual,
				"type":"html",
				"url":"widgets/0/OED/index.html",
				"titulo":"Rotas Transaarianas (séc. I d. C.)"
			};

			console.log(widget);

			window.widgets.elements.push(widget);
		}
	};

	window.configurator = window.configurator || {
		idDiv: "idDiv",

		//obtem a posicao de onde sera incluido o widget no canvas
		getPositionWidgetIcon: function(){
			if(event.toElement.id === "divAreaCanvas"){
				configurator.createWidgetIcon(event.layerX, event.layerY)
			}
		},
		//obtem o id do ultimo widget criado e retorna um novo id
		getIconId: function(){		
			var id = window.localStorage.getItem(configurator.idDiv);
			var newId;
			if(id === null)
				newId = 0;
			else
				newId = parseInt(id);				
			newId +=1;		
			return newId;
		},
			
		createWidgetIcon: function(x, y){
			iconId = configurator.getIconId();
			var newDiv = document.createElement("div");
			newDiv.id = "divWidgetIcon" + iconId;
			newDiv.setAttribute("draggable","true");
			newDiv.setAttribute("ondragstart","return configurator.dragStart(event)");
			newDiv.setAttribute("ondragover","return configurator.dragOver(event)");
			newDiv.setAttribute("onkeypress","configurator.pressKeyCode(this.id)");
			newDiv.style.padding = 5 + "px";
			newDiv.style.width = 10 + "px";
			newDiv.style.height = 5 + "px";
			newDiv.style.resize = "both";
			newDiv.style.overflow = "auto";
			newDiv.style.zIndex = 12;
			newDiv.tabIndex = iconId;
			newDiv.style.backgroundColor="rgba(0,255,0,0.5)"
			newDiv.style.position = "absolute";
			newDiv.style.marginLeft = x + "px";
			newDiv.style.top = y + "px";
			document.getElementById("divAreaCanvas").appendChild(newDiv);
			window.localStorage.setItem(configurator.idDiv,iconId);

			$('#widgetProperties').css('display', 'block');
		},
		pressKeyCode: function(id){
			var div = "#" + id;
			if(event.keyCode === 100){//pressionar D remove o elemento
				document.getElementById(id).remove();
				$('#widgetProperties').css('display', 'none');
			} else if(event.keyCode === 13){//pressionar enter salva posicao e tamanho
				document.getElementById(id).style.opacity = 0.2;
				
				widgets.add(id);
				//configurator.showDetails(id);
				
				$('#widgetProperties').css('display', 'none');
			}
		},
		showDetails: function(id){
			var div = document.getElementById(id);
			console.log("divId: " + id);
			console.log("X: " + div.style.marginLeft);
			console.log("Y: " + div.style.top);
			console.log("Width: " + div.style.width);
			console.log("Height: " + div.style.height);
		},
		/*DRAG AND DROP*/
		dragStart: function (ev) {
			console.log('inicio')
		   ev.dataTransfer.effectAllowed='move';
		   ev.dataTransfer.setData("Text", ev.target.getAttribute('id'));
		   ev.dataTransfer.setDragImage(ev.target,0,0);
		   return true;
		},
		dragEnter: function(ev) {
		   event.preventDefault();
		   return true;
		},
		dragOver: function(ev) {
		    return false;
		},
		dragDrop: function(ev) {
		   var src = ev.dataTransfer.getData("Text");
		   document.getElementById(src).style.position = "absolute";
		   document.getElementById(src).style.marginLeft = ev.layerX + "px";   
		   document.getElementById(src).style.top = ev.layerY + "px";
		   ev.target.appendChild(document.getElementById(src));
		   ev.stopPropagation();
		   $('#' + src).focus()
		   $('#widgetProperties').css('display', 'block');
		   return false;
		},

		adjustLayer : function(){

			//seta tamanho area do canvas para interacao
			$('#divAreaCanvas').css('height', window.imgDefaultHeight);
			$('#divAreaCanvas').css('width', window.imgDefaultWidth);
			$('#divAreaCanvas').css('left', ((window.innerWidth - parseInt($('#divAreaCanvas').css('width'))) / 2) + 'px');
		},

		init : function(){
			$("input[name='widgetType']").change(function(e){
				if(e.target.value == 1){
					$('.widgetPropertiesFields-type-1').css('display', 'block');
					$('.widgetPropertiesFields-type-2').css('display', 'none');
				} else {
					$('.widgetPropertiesFields-type-2').css('display', 'block');
					$('.widgetPropertiesFields-type-1').css('display', 'none');
				}
			});

			$("#saveConfig").click (function(){
				$.ajax({
					type: "get",
					url: "/configurate/save/1/"
				});
			});
			    

			configurator.adjustLayer();
		}
	}
})();