package com.example.demo.exception;

public class NoUserException extends RuntimeException {
    public NoUserException(String message) {
        super(message);
    }
}
