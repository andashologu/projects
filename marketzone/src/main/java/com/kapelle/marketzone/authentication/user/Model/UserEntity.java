package com.kapelle.marketzone.authentication.user.Model;

import java.util.ArrayList;
import java.util.Collection;

import com.kapelle.marketzone.Chat.Model.ChatEntity;
import com.kapelle.marketzone.authentication.user.Validation.UniqueEmailConstraint;
import com.kapelle.marketzone.authentication.user.Validation.UniqueUsernameConstraint;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Embedded;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

@Entity
@Table(name = "users")
public class UserEntity{
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    public Long id;

    @OneToMany(mappedBy = "sender")
    public Collection<ChatEntity> sentChats = new ArrayList<ChatEntity>();

    @OneToMany(mappedBy = "recipient")
    public Collection<ChatEntity> recievedChats = new ArrayList<ChatEntity>();;

    @Pattern(regexp = "^[a-zA-Z]*$", message="Only alphabets allowed in this field")
    public String firstname;
    
    @Pattern(regexp = "^[a-zA-Z]*$", message="Only alphabets allowed in this field")
    public String lastname;

    @Column(name = "profileimage")
    public String profileImg;
    
    @Embedded
    public Address address;

    @NotEmpty(message = "Compulsory field must not be empty")
    @Pattern(regexp = "^(?=.{1,64}@)[A-Za-z0-9_-]+(\\.[A-Za-z0-9_-]+)*@" 
        + "[^-][A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z]{2,})$", message="Incorrect email format")
    /*So some of the email addresses that will be valid via this email validation technique are: username@domain.com, user.name@domain.com, user-name@domain.com, username@domain.co.in, user_name@domain.com
        Here's a shortlist of some email addresses that will be invalid via this email validation: username.@domain.com, .user.name@domain.com, user-name@domain.com., username@.com*/
    @UniqueEmailConstraint
    @Size(max = 100, message = "Name too long")
    public String email;

    @Size(max = 100, message = "Name too long")
    @Column(name = "companyname", columnDefinition = "varchar(100)")
    public String company;

    @NotEmpty(message = "Compulsory field must not be empty")
    @Pattern(regexp = "^[a-zA-Z]*$", message="Only alphabets allowed in this field")
    @UniqueUsernameConstraint
    @Size(max = 100, message = "Name too long")
    public String username;
    
    @NotEmpty(message = "Compulsory field must not be empty")
    @Pattern(regexp = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#&()–[{}]:;',?/*~$^+=<>]).{8,100}$", message="Incorrect password format. Password must be strong")
    public String password;

    @ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinTable( name = "users_roles", 
                joinColumns = @JoinColumn(name = "user_id", referencedColumnName = "id"),
                inverseJoinColumns = @JoinColumn(name = "role_id", referencedColumnName = "id"))
    public Collection<RoleEntity> roles = new ArrayList<RoleEntity>();

    public UserEntity(){}
    
    public UserEntity(String firstname, String lastname, String profileImg, Address address, String email, String company, String username, String password, Collection<RoleEntity> roles){
        this.firstname = firstname;
        this.lastname = lastname;
        this.profileImg = profileImg;
        this.address = address;
        this.email = email;
        this.company = company;
        this.username = username;
        this.password = password;
        this.roles = roles;
    }

    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }

    public Collection<ChatEntity> getSentchats(){
        return sentChats;
    }
    public void setSentchats(Collection<ChatEntity> sentChats){
        this.sentChats = sentChats;
    }

    public Collection<ChatEntity> getRecievedchats(){
        return recievedChats;
    }
    public void setRecievedchats(Collection<ChatEntity> recievedChats){
        this.recievedChats = recievedChats;
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

    public String getProfileimg(){
        return profileImg;
    }
    public void setProfileimg(String profileImg){
        this.profileImg = profileImg;
    }

    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    public void setCompany(String company) {
        this.company = company;
    }
    public String getCompany() {
        return company;
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

    public Collection<RoleEntity> getRoles() {
        return roles;
    }
    public void setRoles(Collection<RoleEntity> roles) {
        this.roles = roles;
    }

    @Override
    public String toString() {
        return "User{" +
                "id = " + id +
                ", sentMessages"+ sentChats +
                ", recievedMessages"+ recievedChats +
                " , firstname = " + firstname +
                " , lastname = " + lastname +
                " , profileImgLink = " + profileImg +
                " , address = " + address +
                " , email = " + email +
                " , company = " + company+
                " , username = " + username +
                " , password = " + password +
                " , roles = " + roles +
                "}";
    }
}
