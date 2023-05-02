package com.kapelle.propertycheck.authentication.user.Model;

import com.kapelle.propertycheck.authentication.user.Validation.UniqueEmailConstraint;
import com.kapelle.propertycheck.authentication.user.Validation.UniqueUsernameConstraint;

import jakarta.persistence.Column;
import jakarta.persistence.Embedded;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Pattern;

@Entity
@Table(name = "users")
public class UserEntity{
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    public Long id;

    @Column(name = "firstname", columnDefinition = "varchar(100)")
    public String firstname;
    
    @Column(name = "lastname", columnDefinition = "varchar(100)")
    public String lastname;
    
    @Embedded
    public Address address;

    @Email(message = "Incorrect email format")
    @UniqueEmailConstraint
    @Column(name = "email", columnDefinition = "varchar(100)")
    public String email;

    @Column(name = "username", columnDefinition = "varchar(100)")
    @UniqueUsernameConstraint
    public String username;
    
    @Pattern(regexp ="^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#&()–[{}]:;',?/*~$^+=<>]).{8,200}$", message="Incorrect password format")
    @Column(name = "password", columnDefinition = "varchar(100)")
    public String password;

    @Column(name = "role", columnDefinition = "varchar(100)")
    public String role = "USER";
    
    public UserEntity(String firstname, String lastname, Address address, String email, String username, String password, String role){
        this.firstname = firstname;
        this.lastname = lastname;
        this.address = address;
        this.email = email;
        this.username = username;
        this.password = password;
        this.role = role;
    }

    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }

    public String getFirstname() {
        return firstname;
    }
    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }
    
    public String getLastname() {
        return lastname;
    }
    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }

    public Address getAddress() {
        return address;
    }
    public void setAddress(Address address) {
        this.address = address;
    }
    
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }
    public void setRole(String role) {
        this.role = role;
    }
    
    @Override
    public String toString() {
        return "User{" +
                "id = " + id +
                " , firstname = " + firstname +
                " , lastname = " + lastname +
                " , address = " + address +
                " , email = " + email +
                " , username = " + username +
                " , password = " + password +
                " , role = " + role +
                "}";
    }
}
