$('.smart-form').each(function() {
        $(this).validate({
                /* @validation states + elements 
                ------------------------------------------- */
                
                errorClass: "state-error",
                validClass: "state-success",
                errorElement: "em",
                
                /* @validation rules 
                ------------------------------------------ */
                    
                rules: {
                        price: {
                                required: true,
                                number: true
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
                        mobile: {
                            required: true,
                            minlength:10,
                            maxlength:10,
                            number: true,
                        },
                        newpasswordconfirm: {
                            required: function(element){
                                return $('.newpassword').val() != "";
                            },
                            equalTo: '.newpassword'
                        },
                        currentpassword: {
                            required: true
                        },
                        "book_group[title]": {
                            required: true,
                        },
                        "book_group[author]": {
                            required: true,
                        },
                        "book_group[publisher]": {
                            required: true,
                        },
                        "book_group[books_attributes][0][price]": {
                            required: true,
                            number: true,
                        },
                        "user[email]": {
                            required: true,
                            email: true,
                        },
                        "user[password]": {
                            required: true,
                        },
                        "user[first_name]": {
                            required: true,
                        },
                        "user[last_name]": {
                            required: true,
                        },
                        "user[mobile]": {
                            required: true,
                            minlength:10,
                            maxlength:10,
                            number: true,
                        },
                        "guest[email]": {
                            required: true,
                            email: true,
                        },
                        "guest[first_name]": {
                            required: true,
                        },
                        "guest[last_name]": {
                            required: true,
                        },
                        "guest[mobile]": {
                            required: true,
                            minlength:10,
                            maxlength:10,
                            number: true,
                        },
                        name: {
                            required: true,
                        },
                        email: {
                            required: true,
                            email: true,
                        },
                        message: {
                            required: true,
                        },
                        college_name: {
                            required: true,
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