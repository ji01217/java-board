package com.example.demo.controller;

import com.example.demo.dto.UserDTO;
import com.example.demo.exception.NoUserException;
import com.example.demo.exception.MyLoginException;
import com.example.demo.exception.SignupException;
import com.example.demo.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    // 회원가입 화면
    @GetMapping("/signup")
    public String userJoin(Model model) {
        model.addAttribute("purpose", "회원가입");
        return "user/UserForm";
    }

    // 가입버튼을 눌렀을 때
    @PostMapping("/signup")
    public ResponseEntity<String> userJoin(UserDTO userDTO) throws Exception {
        try {
            userService.signup(userDTO);
            return ResponseEntity.ok().build();
        } catch (SignupException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    // 아이디 중복 검사
    @GetMapping("/checkDuplicateId/{id}")
    @ResponseBody
    public boolean checkDuplicateId(@PathVariable String id) {
        return userService.checkDuplicateId(id);
    }

    // 로그인 화면
    @GetMapping("/login")
    public String login() {
        return "user/Login";
    }

    // 로그인 버튼 눌렀을 때
    @PostMapping("/userlogin")
    public ResponseEntity<String> login(@RequestBody UserDTO user, HttpSession session) {
        try {
            userService.login(user.getId(), user.getPassword());
            // 로그인 성공 시 세션에 아이디 저장 및 200 ok 반환
            session.setAttribute("id", user.getId());
            return ResponseEntity.ok().build();
        } catch (MyLoginException e) {
            // 로그인 실패 시 400 Bad Request와 에러 메시지 반환
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    // 로그아웃
    @PostMapping("/logout")
    public String logout(HttpSession session) {
        session.removeAttribute("id");
        return "redirect:/article/list";
    }

    // 회원정보 수정
    @GetMapping("/edit")
    public String editUser(Model model, HttpSession session) {
        String loginUser = (String) session.getAttribute("id");
        if (loginUser == null) {
            return "redirect:/user/login";
        }
        UserDTO user = userService.getUserById(loginUser);
        model.addAttribute("user", user);
        model.addAttribute("purpose", "회원정보수정");
        return "user/UserForm";
    }

    @PostMapping("/edit")
    public ResponseEntity<String> editUser(UserDTO user, HttpSession session) {
        try {
            userService.editUser(user, session);
            return ResponseEntity.ok().build();
        } catch (NoUserException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/profile")
    public String profile(HttpSession session, Model model) {
        String loginUser = (String) session.getAttribute("id");
        if (loginUser == null) {
            return "redirect:/user/login";
        }
        UserDTO user = userService.getUserById(loginUser);
        model.addAttribute("user", user);
        return "user/Profile";
    }

    @PostMapping("/signout")
    public ResponseEntity<String> signOut(String password, HttpSession session) {
        try {
            userService.signOut(session, password);
            session.removeAttribute("id");
            return ResponseEntity.ok().build();
        } catch (NoUserException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}
