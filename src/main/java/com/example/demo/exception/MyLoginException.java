package com.example.demo.exception;

public class MyLoginException extends RuntimeException {
    public MyLoginException(String message) {
        super(message);
    }
}