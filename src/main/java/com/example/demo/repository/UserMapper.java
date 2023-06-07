package com.example.demo.repository;

import com.example.demo.dto.UserDTO;
import org.springframework.stereotype.Repository;

@Repository
public interface UserMapper {

    // 회원가입
    void signup(UserDTO userDTO);

    UserDTO getUserById(String id);

    UserDTO getValidUserById(String id);

    void editUser(UserDTO user);
}
