package com.example.demo.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserDTO {
    private String id;
    private String password;
    private String name;
    private String birth;
    private String gender;
    private String email;
    private String phone;
    private boolean deleted;

    public void signOut() {
        deleted = true;
    }
}