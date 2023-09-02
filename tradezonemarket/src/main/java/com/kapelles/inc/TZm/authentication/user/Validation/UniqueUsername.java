package com.kapelles.inc.TZm.authentication.user.validation;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

import org.springframework.beans.factory.annotation.Autowired;

import com.kapelles.inc.TZm.authentication.user.model.UserEntity;
import com.kapelles.inc.TZm.authentication.user.model.UserRepository;

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