package com.rezanbt.weblager.entities;
import java.io.Serializable;
import java.util.Set;

import javax.persistence.*;
@Entity
@Table(name="user")
public class User implements Serializable {

	
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue
	@Column(name = "id", updatable = false, nullable = false)
	private int id;
	@Column(name="username")
	private String username;
	@Column(name="password")
	private String password;
	@Column(name="passwordConfirm")
	@Transient
	private String passwordConfirm;
	@Column(name="fullname")	
	private String fullname;
	@Column(name="country")	
	private String country;
	@Column(name="enabled")	
	private short enabled;
	@ManyToMany
    @JoinTable(name = "user_role", joinColumns = @JoinColumn(name = "user_id"), inverseJoinColumns = @JoinColumn(name = "role_id"))
    private Set<Role> roles;
    

	 public int getId() { return id; }
	 public void setId(int id) { this.id = id; }
	 
	 
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getFullname() {
		return fullname;
	}
	public void setFullname(String fullname) {
		this.fullname = fullname;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	
	public String getPasswordConfirm() {
		return passwordConfirm;
	}
	public void setPasswordConfirm(String passwordConfirm) {
		this.passwordConfirm= passwordConfirm;
	}
	public void setEnabled(short enabled) {
		this.enabled = enabled;
	}

    
    public Set<Role> getRoles() {
        return roles;
    }

    public void setRoles(Set<Role> roles) {
        this.roles = roles;
    }
    @Override
    public String toString(){
    	  return String.format(
                  "User[id=%d, fullName='%s', username='%s']",
                  id, fullname, username);
    }
    
} 

