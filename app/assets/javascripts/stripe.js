//4242424242424242
// this identifies your website in the createToken call below

Stripe.setPublishableKey($('meta[name="stripe_public_key"]').attr('content'));
var person_name = $('meta[name="person_name"]').attr('content')

function stripeResponseHandler(status, response) {
    if (response.error) {
        // re-enable the submit button
        $('#submit-button').removeAttr("disabled");
        // show the errors on the form
        $("#payment-errors").html(response.error.message);
				$("#payment-errors").addClass("alert alert-error")
    } else {
	
				$("#payment-errors").html("<strong>Thank You!</strong><br/> Your payment has been receieved!");
				$("#payment-errors").removeClass("alert alert-error");
				$("#payment-errors").addClass("alert alert-success");
        
        var form$ = $("#payment-form");
        // token contains id, last4, and card type
        var token = response['id'];

        // insert the token into the form so it gets submitted to the server
        $('#payment_stripe_card_token').val(token)
				$('#payment-form')[0].submit()
				
    }
}

function isNumber(n) {
  return !isNaN(parseFloat(n)) && isFinite(n);
}

function validateEmail(email) { 
  // http://stackoverflow.com/a/46181/11236
    var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}

$(document).ready(function() {
		
    $("#payment-form").submit(function(event) {
				
				if ($('#payment_name').val() == "") {
					$("#payment-errors").html("Please remember to enter <strong>your name</strong>.");
					$("#payment-errors").addClass("alert alert-error")
					return false;
				}
				
				if ($('#payment_email').val() == "" ||
						!validateEmail($('#payment_email').val())) {
					$("#payment-errors").html("Please enter a valid <strong>email</strong>.");
					$("#payment-errors").addClass("alert alert-error")
					return false;
				}
				
				if ($('#payment_amount').val() == undefined || 
						$('#payment_amount').val() == "" || 
						!isNumber($('#payment_amount').val()) ) {
					$("#payment-errors").html("Please enter a <strong>transaction amount</strong> in dollars.");
					$("#payment-errors").addClass("alert alert-error")
					return false;
				}
				
				if ($('#card_number').val() == undefined ||
						$('#card_number').val() == "" ||
						!isNumber($('#card_number').val()) ) {
					$("#payment-errors").html("Please enter your valid <strong>credit card number</strong>.");
					$("#payment-errors").addClass("alert alert-error")
					return false;
				}
				
				if ($('#card_code').val() == undefined ||
						$('#card_code').val() == "" ||
						!isNumber($('#card_code').val()) ) {
					$("#payment-errors").html("Please correctly enter your <strong>card security code</strong>.");
					$("#payment-errors").addClass("alert alert-error")
					return false;
				}
				
				
				
				var chargeAmount = $('#payment_amount').val() * 100;

				
				var displayedAmount = chargeAmount / 100;
				if (displayedAmount < .50) {
					$("#payment-errors").html("The <strong> minimum </strong> payment amount is <strong>$.50</strong>");
					$("#payment-errors").addClass("alert alert-error")
					return false;
				}
					
				
				var cont = confirm("Are you sure you want to pay " + person_name + " $" + displayedAmount + " ?");
				if (!cont) {
					alert("Your payment was NOT submitted!");
					return false;
				}
				
        // disable the submit button to prevent repeated clicks
        $('#submit-button').attr("disabled", "disabled");
        
        // createToken returns immediately - the supplied callback submits the form if there are no errors
        Stripe.createToken({
            number: $('#card_number').val(),
            cvc: $('#card_code').val(),
            exp_month: $('#card_month').val(),
            exp_year: $('#card_year').val()
        }, chargeAmount, stripeResponseHandler);
        return false; // submit from callback
    });

});