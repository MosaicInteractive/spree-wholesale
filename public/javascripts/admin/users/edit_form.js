jQuery(document).ready(function(){
  
  $.each($('td.unique_wholesale_price input'), function(i, inpt){
    $(inpt).delayedObserver(1.0, function(object, value) {

      var id = object.attr('id').replace("user_wholesale_products_attributes_", "").replace("_unique_wholesale_price", "");
      id = "#user_wholesale_products_attributes_" + id + "_id";

      jQuery.ajax({
        type: "POST",
        url: "/admin/users/" + $('input#user_id').val() + "/wholesale_products/" + $(id).val(),
        data: ({_method: "put", "wholesale_product[unique_wholesale_price]": value}),
        success: function(html){ $('#user-form-wrapper').html(html)}
      });

    });
  });
  
  $.each($('td.unique_wholesale_price_usd input'), function(i, inpt){
    $(inpt).delayedObserver(1.0, function(object, value) {

      var id = object.attr('id').replace("user_wholesale_products_attributes_", "").replace("_unique_wholesale_price_usd", "");
      id = "#user_wholesale_products_attributes_" + id + "_id";

      jQuery.ajax({
        type: "POST",
        url: "/admin/users/" + $('input#user_id').val() + "/wholesale_products/" + $(id).val(),
        data: ({_method: "put", "wholesale_product[unique_wholesale_price_usd]": value}),
        success: function(html){ $('#user-form-wrapper').html(html)}
      });

    });
  });
  
});