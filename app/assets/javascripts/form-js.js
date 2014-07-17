$(function() {
        $( ".smart-form" ).validate({
        
                /* @validation states + elements 
                ------------------------------------------- */
                
                errorClass: "state-error",
                validClass: "state-success",
                errorElement: "em",
                
                /* @validation rules 
                ------------------------------------------ */
                    
                rules: {
                        price: {
                                required: true
                        },
                        book_title: {
                                required: true
                        },                  
                        category: {
                                required: true
                        },
                        author: {
                            required: true
                        },
                        publisher: {
                            required:true
                        },
                        edition: {
                            required: true
                        },
                        isbn: {
                            required: true
                        },
                        firstname: {
                            required: true
                        },
                        lastname: {
                            required: true
                        },
                        "user[email]": {
                            required: true,
                            email: true
                        },
                        "user[password]": {
                            required: true
                        },
                        mobile: {
                            required: true,
                            minlength:10,
                            maxlength:10
                        },
                        newpasswordconfirm: {
                            required: function(element){
                                return $('.newpassword').val() != "";
                            },
                            equalTo: '.newpassword'
                        },
                        currentpassword: {
                            required: true
                        }                        
                },
                
                /* @validation error messages 
                ---------------------------------------------- */
                    
                messages:{
                    email:{
                        email: 'Please enter a valid email'
                    },
                    mobile: {
                        minlength: 'Mobile No Should be of 10 digits',
                        maxlength: 'Mobile No Should be of 10 digits'
                    }

                },

                /* @validation highlighting + error placement  
                ---------------------------------------------------- */ 
                
                highlight: function(element, errorClass, validClass) {
                        $(element).closest('.field').addClass(errorClass).removeClass(validClass);
                },
                unhighlight: function(element, errorClass, validClass) {
                        $(element).closest('.field').removeClass(errorClass).addClass(validClass);
                },
                errorPlacement: function(error, element) {
                   if (element.is(":radio") || element.is(":checkbox")) {
                            element.closest('.option-group').after(error);
                   } else {
                            error.insertAfter(element.parent());
                   }
                }
                        
        });     

});
