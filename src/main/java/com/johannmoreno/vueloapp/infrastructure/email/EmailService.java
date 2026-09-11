package com.johannmoreno.vueloapp.infrastructure.email;

import jakarta.mail.MessagingException;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;

public class EmailService {

    private static final String BREVO_API_KEY = System.getenv("BREVO_API_KEY");
    private static final String REMITENTE_EMAIL = System.getenv("REMITENTE_EMAIL");
    private static final String REMITENTE_NOMBRE = "VueloApp";

    public void enviarCorreo(String destinatario, String asunto, String cuerpo) throws MessagingException {
        if (BREVO_API_KEY == null || REMITENTE_EMAIL == null) {
            throw new MessagingException("Las credenciales de correo no estan configuradas. " +
                    "Verifica las variables de entorno BREVO_API_KEY y REMITENTE_EMAIL.");
        }

        String asuntoEscapado = escaparJson(asunto);
        String cuerpoEscapado = escaparJson(cuerpo);

        String json = "{"
                + "\"sender\":{\"name\":\"" + REMITENTE_NOMBRE + "\",\"email\":\"" + REMITENTE_EMAIL + "\"},"
                + "\"to\":[{\"email\":\"" + destinatario + "\"}],"
                + "\"subject\":\"" + asuntoEscapado + "\","
                + "\"textContent\":\"" + cuerpoEscapado + "\""
                + "}";

        try {
            HttpClient client = HttpClient.newBuilder()
                    .connectTimeout(Duration.ofSeconds(10))
                    .build();

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create("https://api.brevo.com/v3/smtp/email"))
                    .header("accept", "application/json")
                    .header("api-key", BREVO_API_KEY)
                    .header("content-type", "application/json")
                    .timeout(Duration.ofSeconds(10))
                    .POST(HttpRequest.BodyPublishers.ofString(json))
                    .build();

            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

            if (response.statusCode() >= 400) {
                throw new MessagingException("Error del servicio de correo (Brevo): " +
                        response.statusCode() + " - " + response.body());
            }
        } catch (MessagingException e) {
            throw e;
        } catch (Exception e) {
            throw new MessagingException("Error al enviar el correo via Brevo: " + e.getMessage());
        }
    }

    private String escaparJson(String texto) {
        return texto.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "");
    }
}