package com.johannmoreno.vueloapp.business.exceptions;

public class DuplicateUsuarioException extends Exception {
    public DuplicateUsuarioException(String message) {
        super(message);
    }
}