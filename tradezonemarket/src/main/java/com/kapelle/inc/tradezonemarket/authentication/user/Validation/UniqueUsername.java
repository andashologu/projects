package com.kapelle.inc.tradezonemarket.authentication.user.Validation;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

import org.springframework.beans.factory.annotation.Autowired;

import com.kapelle.inc.tradezonemarket.authentication.user.Model.UserEntity;
import com.kapelle.inc.tradezonemarket.authentication.user.Model.UserRepository;

public class UniqueUsername implements ConstraintValidator<UniqueUsernameConstraint, String> {

    @Autowired
    UserRepository userRespository;

    @Override
    public void initialize(UniqueUsernameConstraint username) {
    }

    @Override
    public boolean isValid(String username, ConstraintValidatorContext cxt) {
        if(username == null) {
            return false;
        }
        try {
            UserEntity user = userRespository.findByUsernameIgnoreCase(username);
            if(user != null) {
                return false;
            } else if(username.equalsIgnoreCase("You")) {//reserved username
                return false;
            } else {
                return true;
            }
        } catch(Exception e) {
            return true;
        }
    }
}