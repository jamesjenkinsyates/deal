$('.available').bind('inview', function(event, isInView, visiblePartX, visiblePartY) {
  if (isInView) {
      var offerId = $(this).data('id');
      $.post( "/impressions", { "offer_id": offerId } );
      $(this).unbind('inview');
    }
});






$(document).ready(function() {
  $('body').on('click', '.available_offers a', function(e) {
    e.preventDefault();

    if(!$(this).hasClass('click-logged')) {
      e.stopPropagation();
      console.log("Something happened")

      var link = this;
      var offerId = $(this).data('offer-id');

      $.post( "/clicks", { "offer_id": offerId }, function(){
        $(link).addClass('click-logged').trigger('click');
      });
    }
  });
});

        // $('.show-preferences').click(function(){                   
        //   //make the collapse content to be shown or hide
        //   var toggle_switch = $(this);
        //   $('.preferences').toggle(function(){
        //     if($(this).css('display')=='none'){
        //                       //change the button label to be 'Show/Change Preferences'
        //       toggle_switch.html('Show/Change Preferences');
        //     }else{
        //                       //change the button label to be 'Hide Preferences'
        //       toggle_switch.html('Hide Preferences');
        //     }
        //   });
        // });
        // });

  // if($('.available_offers').length) {
  //   $.get('/businesses.json', function(businesses) {
  //     businesses.forEach(function(business) {
  //       addOffersForBusiness(business);
  //     })
  //   });
  // }
// });
  // $.get('/offers.json', function(businesses) {
  //     addOffersForBusiness(businesses);
  // });


// $(document).ready(function() {
//   $('.show-preferences').click(function(){                   
//     //make the collapse content to be shown or hide
//     var toggle_switch = $(this);
//     $('.preferences').toggle(function(){
//       if($(this).css('display')=='none'){
//                         //change the button label to be 'Show/Change Preferences'
//         toggle_switch.html('Show/Change Preferences');
//       }else{
//                         //change the button label to be 'Hide Preferences'
//         toggle_switch.html('Hide Preferences');
//       }
//     });
//   });

// });




$(document).ready(function () {
  $('.show-preferences').on('click', function(){
    $('.preferences').toggleClass('revealed');
  })
});

// http://patik.com/blog/within-viewport-javascript-and-jquery-plugin/
// https://github.com/patik/within-viewport
// http://www.appelsiini.net/projects/viewport

  $('.available_offers').on('inview', '.available', function(event, isInView, visiblePartX, visiblePartY) {
    if (isInView) {
        console.log("whole element is visible");
        var offerId = $(this).data('offer-id');
        $.post( "/impressions", { "offer_id": offerId } );
        $(this).unbind('inview');
    }
});
  
$('.see-offer-link').click(function() {
  console.log("clicked")
  var offerId = $(this).data('offer-id');
  $.post( "/clicks", { "offer_id": offerId } );
});

// });

$.get('/businesses.json', function(businesses) {
  businesses.forEach(function(business) {
    addOffersForBusiness(business);
  })
});

