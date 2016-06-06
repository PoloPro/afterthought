
  $(function() {
    var urlLocation = window.location.href.match(/\bcourses\b$/)
    var uiWidgetText = $(".ui-widget").text()
    if(urlLocation !== null && urlLocation[0] === "courses" && uiWidgetText !== "") {
    $.widget( "custom.catcomplete", $.ui.autocomplete, {
        _create: function() {
          this._super();
          this.widget().menu( "option", "items", "> :not(.ui-autocomplete-category)" );
        },
        _renderMenu: function( ul, items ) {
          var that = this,
            currentCategory = "";
          $.each( items, function( index, item ) {
            var li;
            if ( item.category != currentCategory ) {
              ul.append( "<li class='ui-autocomplete-category'>" + "<b>" + item.category + "<b>" + "</li>" );
              currentCategory = item.category;
            }
            li = that._renderItemData( ul, item );
            if ( item.category ) {
              li.attr( "aria-label", item.category + " : " + item.label );
            }
          });
        }
      });
    var data = [
      { label: "anders", category: "" },
      { label: "andreas", category: "" },
      { label: "antal", category: "" },
      { label: "annhhx10", category: "Products" },
      { label: "annk K12", category: "Products" },
      { label: "annttop C13", category: "Products" },
      { label: "anders andersson", category: "People" },
      { label: "andreas andersson", category: "People" },
      { label: "andreas johnson", category: "People" }
    ];

    $( "#search" ).catcomplete({
      delay: 0,
      source: data
    });
  }
  });


  // $.ajax({
  //       type: "GET",
  //       dataType: "json",
  //       url: "/courses/get_courses",
  //       success: function(data){}
  //   });
