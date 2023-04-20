package com.kapelle.propertycheck.PropertyCheck.Controller;


//@Controller
public class User{
    /* 
    @GetMapping("/user/settings/update-account")
    public String accountSettings(){
        //return id with model attributes
        return "edit/account";
    }
    @PutMapping("/user/post/edit/{id}")
    public ResponseEntity<UserEntity> updateUser(@PathVariable (value = "id") Long id, @Valid @RequestBody UserEntity userDetails) throws ResourceNotFoundException{
        UserEntity user = userRepository.findById(id)
        orElseThrow(() -> new ResourceNotFoundException("User Not found for this id :: "+id));

        user.setId(id);
        user.setFirstname(userDetails.getFirstname());
        user.setLastname(userDetails.getLastname());
        user.setUsername(userDetails.getUsername());
        /*email must not be updated
         * password must be update through password reset
         */

        /*
         * Must make sure the new user does not replace other fields with null
         */
        /**
         * The ubove details must be validated before saving....
         */
        /* 
        final UserEntity updatedUser = userRepository.save(user);
        return ResponseEntity.ok(updatedUser);
    }
    @DeleteMapping("/user/settings/delete-account")
    public String deleteAccount(){
        return null;
    }
    @GetMapping("/user/settings/payment-informartion")
    public String paymentInfo(){
        return null;
    }
    @PutMapping("/user/settings/update-payment")
    public String editPaymentInfo(){
        return null;
    }
    @DeleteMapping("/user/settings/remove-payment")
    public String deletePayment(){
        return null;
    }
    @GetMapping("/admin/panel")
    public String deleteAccount(){
        return null;
    }
    @DeleteMapping("/admin/remove/{username}")
    public String deleteAccount(){
        return null;
    }
    @PutMapping("/admin/deactivate/{username}")
    public ResponseEntity<User> deleteAccount(){
        return null;
    }*/

} 
