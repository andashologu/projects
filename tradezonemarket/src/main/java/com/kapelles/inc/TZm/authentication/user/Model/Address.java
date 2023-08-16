package com.kapelles.inc.TZm.authentication.user.Model;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import jakarta.validation.constraints.Size;

@Embeddable
public class Address {

    @Size(max = 100, message = "Name too long")
    private String street;

    @Size(max = 100, message = "Name too long")
    private String city;

    @Size(max = 100, message = "Name too long")
    private String country;

    @Size(max = 100, message = "Name too long")
    @Column(name="zipcode")
    private String zip;

    public Address() {}
    public Address(String street, String city, String country, String zip) {
        this.street = street;
        this.city = city;
        this.country = country;
        this.zip = zip;
    }

    public String getStreet() {
        return street;
    }
    public void setStreet(String street) {
        this.street = street;
    }

    public String getCity() {
        return city;
    }
    public void setCity(String city) {
        this.city = city;
    }

    public String getCountry() {
        return country;
    }
    public void setCountry(String country) {
        this.country = country;
    }

    public String getZip() {
        return zip;
    }
    public void setZip(String zip) {
        this.zip = zip;
    }

    @Override
    public String toString() {
        return "Address{" +
                "street = " + street +
                " , city = " + city +
                " , country = " + country +
                " , zip = " + zip +
                "}";
    }
}
