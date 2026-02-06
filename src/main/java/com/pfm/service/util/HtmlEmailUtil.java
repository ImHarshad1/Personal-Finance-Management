package com.pfm.service.util;

import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.Map;

import org.springframework.stereotype.Component;

@Component
public class HtmlEmailUtil {

    public String getHtmlContent(String fileName) {
        try (InputStream is = getClass()
                .getClassLoader()
                .getResourceAsStream("templates/" + fileName)) {

            if (is == null) {
                throw new RuntimeException("HTML template not found: " + fileName);
            }

            return new String(is.readAllBytes(), StandardCharsets.UTF_8);

        } catch (Exception e) {
            throw new RuntimeException("Failed to load HTML file: " + fileName, e);
        }
    }

    public String replacePlaceholders(String html, Map<String, String> values) {
        if (html == null || values == null) {
            return html;
        }

        String result = html;

        for (Map.Entry<String, String> entry : values.entrySet()) {
            String key = entry.getKey();
            String value = entry.getValue() != null ? entry.getValue() : "";
            result = result.replace("{{" + key + "}}", value);
        }

        return result;
    }
}
