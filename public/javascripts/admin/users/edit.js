jQuery(document).ready(function(){
  image_html = function(item){
    return "<img src='/assets/products/" + item['images'][0]["id"] + "/mini/" + item['images'][0]['attachment_file_name'] + "'/>";
  }

  format_autocomplete = function(data){
    var html = "";
    var price_type = $("#price_type").val();
    var price = '';
    
    var product = data['product'];

    if(data['variant']==undefined){
      // product

      if(product['images'].length!=0){
        html = image_html(product);
      }
      
      price = format_price(product, price_type)
      
      html += "<div><h4>" + product['name'] + price + "</h4>";
      html += "<span><strong>Sku: </strong>" + product['master']['sku'] + "</span>";
      html += "<span><strong>On Hand: </strong>" + product['count_on_hand'] + "</span></div>";
    }else{
      // variant
      var variant = data['variant'];
      var name = product['name'];

      if(variant['images'].length!=0){
        html = image_html(variant);
      }else{
        if(product['images'].length!=0){
          html = image_html(product);
        }
      }
      
      price = format_price(variant, price_type)
      
      name += " - " + $.map(variant['option_values'], function(option_value){
        return option_value["option_type"]["presentation"] + ": " + option_value['name'];
      }).join(", ")
      
      html += "<div><h4>" + name + price + "</h4>";
      html += "<span><strong>Sku: </strong>" + variant['sku'] + "</span>";
      html += "<span><strong>On Hand: </strong>" + variant['count_on_hand'] + "</span></div>";
    }


    return html
  }

   format_price = function(product_or_variant, price_type) {
    var price = '';
    switch(price_type) {
      case "price": 
      if (product_or_variant['price'] != undefined) { 
        price += " - " + product_or_variant['price'].toFixed(2) + " CAD" 
      };
      break;
      case "price_usd": 
      if (product_or_variant['price_usd'] != undefined) { 
        price += " - " + product_or_variant['price_usd'].toFixed(2) + " USD" 
      } else {
        price += " - " + product_or_variant['price'].toFixed(2) + " USD"
      };
      break;
      case "wholesale": 
      if (product_or_variant['wholesale_price'] != undefined) { 
        price += " - " + product_or_variant['wholesale_price'].toFixed(2) + " CAD" 
      } else {
        price += " - " + product_or_variant['price'].toFixed(2) + " CAD"
      };
      break;
      case "wholesale_usd": 
      if (product_or_variant['wholesale_price_usd'] != undefined) { 
        price += " - " + product_or_variant['wholesale_price_usd'].toFixed(2) + " USD"
      } else if (product_or_variant['wholesale_price'] != undefined) {
        price += " - " + product_or_variant['wholesale_price'].toFixed(2) + " USD"
      } else if (product_or_variant['price_usd'] != undefined) {
        price += " - " + product_or_variant['price_usd'].toFixed(2) + " USD"
      } else {
        price += " - " + product_or_variant['price'].toFixed(2) + " USD"
      };
      break;
      default:
      if (product_or_variant['price'] != undefined) { 
        price += " - " + product_or_variant['price'].toFixed(2) + " CAD" 
      };
      break;
    };
    return price
  }
  
  prep_autocomplete_data = function(data){
    return $.map(eval(data), function(row) {
      var price_type = $("#price_type").val();
      var price = '';
      var product = row['product'];

      if(product['variants'].length>0 && expand_variants){
        //variants
        return $.map(product['variants'], function(variant){
          price = format_price(variant, price_type)
          var name = product['name'];
          name += " - " + $.map(variant['option_values'], function(option_value){
            return option_value["option_type"]["presentation"] + ": " + option_value['name'];
          }).join(", ");

          return {
              data: {product: product, variant: variant},
              value: name,
              result: name + price
          }
        });
      }else{
        price = format_price(product, price_type)
        return {
            data: {product: product},
            value: product['name'],
            result: product['name'] + price
        }
      }
    });
  }

  $("#add_product_name").autocomplete("/admin/products.json", {
      parse: prep_autocomplete_data,
      formatItem: function(item) {
        return format_autocomplete(item);
      }
    }).result(function(event, data, formatted) {
      if (data){
        if(data['variant']==undefined){
          // product
          $('#add_variant_id').val(data['product']['master']['id']);
        }else{
          // variant
          $('#add_variant_id').val(data['variant']['id']);
        }
      }
    });

});

