package com.kapelle.marketzone.authentication.user.Model;

import java.util.Set;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "roles")
public class RoleEntity {

    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    public Long id;

    public String name;

    @ManyToMany(mappedBy = "roles")
    @Column(name = "users")
    public Set<UserEntity> users;

    public RoleEntity() {}

    public RoleEntity(String name) {
        this.name = name;
    }

    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    public Set<UserEntity> getUsers() {
        return users;
    }
    public void setUsers(Set<UserEntity> users) {
        this.users = users;
    }
    
    @Override
    public String toString() {
        return "User{" +
                "id = " + id +
                " , name = " + name +
                " , users = " + users +
                "}";
    }
}