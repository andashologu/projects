package com.kapelles.inc.TZm.authentication.user.Validation;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

import org.springframework.beans.factory.annotation.Autowired;

import com.kapelles.inc.TZm.authentication.user.Model.UserEntity;
import com.kapelles.inc.TZm.authentication.user.Model.UserRepository;



public class UniqueEmail implements ConstraintValidator<UniqueEmailConstraint, String> {

    @Autowired
    UserRepository userRespository;

    @Override
    public void initialize(UniqueEmailConstraint email) {
    }

    @Override
    public boolean isValid(String email, ConstraintValidatorContext cxt) {
        if(email == null) {
            return false;
        }
        try{
            UserEntity user = userRespository.findByEmailIgnoreCase(email);
            if(user != null) {
                return false;
            } else {
                return true;
            }
        } catch(Exception e){
            return true;
        }
    }
}