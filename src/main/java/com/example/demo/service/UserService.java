package com.example.demo.service;

import com.example.demo.dto.UserDTO;
import com.example.demo.exception.NoUserException;
import com.example.demo.exception.MyLoginException;
import com.example.demo.exception.SignupException;
import com.example.demo.exception.SignoutException;
import com.example.demo.repository.UserMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserMapper userMapper;

    private final PasswordEncoder passwordEncoder;

    public void signup(UserDTO userDTO) throws SignupException {
        // 중복된 아이디 체크
        if (checkDuplicateId(userDTO.getId())) {
            throw new SignupException("사용할 수 없는 아이디입니다.");
        }
        // 비밀번호 암호화
        String encodedPassword = passwordEncoder.encode(userDTO.getPassword());
        userDTO.setPassword(encodedPassword);
        userMapper.signup(userDTO);
    }

    public boolean checkDuplicateId(String id) {
        UserDTO user = userMapper.getUserById(id);
        return (user != null);
    }

    public void login(String id, String password) throws MyLoginException {
        UserDTO user = userMapper.getValidUserById(id);
        if (user == null) {
            throw new MyLoginException("존재하지 않는 아이디입니다.");
        }
        if (!passwordEncoder.matches(password, user.getPassword())) {
            throw new MyLoginException("비밀번호가 일치하지 않습니다.");
        }
    }

    public UserDTO getUserById(String id) {
        return userMapper.getUserById(id);
    }

    public void editUser(UserDTO user, HttpSession session) throws NoUserException {
        if (session.getAttribute("id") == null) {
            throw new NoUserException("로그인하고 다시 시도해주세요.");
        }
        String encodedPassword = passwordEncoder.encode(user.getPassword());
        user.setPassword(encodedPassword);
        userMapper.editUser(user);
    }

    public void signOut(HttpSession session, String password) throws NoUserException, SignoutException {
        String loginUser = (String) session.getAttribute("id");
        UserDTO user = userMapper.getValidUserById(loginUser);
        if (loginUser == null) {
            throw new NoUserException("로그인하고 다시 시도해주세요.");
        }
        if (!passwordEncoder.matches(password, user.getPassword())) {
            throw new SignoutException("비밀번호가 일치하지 않습니다.");
        }
        user.signOut();
        userMapper.editUser(user);
    }
}
