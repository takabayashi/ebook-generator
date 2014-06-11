// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .
//= require pace/pace

var app = app || {
	books : [],

	addBook : function(book){
			
		book.widgets = [];

		book.addWidget = function(widget){
			this.widgets.push(widget);
		};

		book.sumaryItems = [];

		book.addSumaryItem = function(sumaryItem){
			this.sumaryItems.push(sumaryItem);
		};

		app.books.push(book);
	},

	getBook : function(bookId){
		var book = null;

		$(app.books).each(function(index, element){ 
			if(element.id === bookId) {
				book = element;

				return true;
			}
		});

		return book;
	}
};

///teste
/**app.addBook(1);
app.addBook(2);

var b = app.getBook(2);
b.addWidget({defaultTopLocation : 10,
				defaultLeftLocation : 0,
				topLocation : 0,
				leftLocation : 0,
				width : 0,
				height : 0,
				pagina : 0,
				type : null,
				url : "ssssss",
				titulo : null});

b.addSumaryItem({defaultTopLocation : -10, 
				defaultLeftLocation : 0, 
				topLocation : 0, 
				leftLocation : 0, 
				width : 0, 
				height : 0, 
				pagina : 0, 
				paginaTarget : 0});

console.log(JSON.stringify(b));
*/