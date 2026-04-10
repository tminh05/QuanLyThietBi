package multicast_maven; // Sửa lại tên package cho đúng với Project Maven của bạn

import org.java_websocket.server.WebSocketServer;
import org.java_websocket.WebSocket;
import org.java_websocket.handshake.ClientHandshake;
import javax.swing.*;
import java.awt.*;
import java.net.InetSocketAddress;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class MulticastReceiver extends JFrame {
    private JTextArea logArea;
    private JLabel statusLabel;
    private final DateTimeFormatter dtf = DateTimeFormatter.ofPattern("HH:mm:ss");

    public MulticastReceiver() {
        setTitle("🔥 CLOUD SERVER - PHONG NHAN TIN 🔥");
        setSize(500, 400);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        setLocationRelativeTo(null);

        logArea = new JTextArea();
        logArea.setBackground(new Color(30, 30, 30));
        logArea.setForeground(new Color(50, 255, 50));
        logArea.setFont(new Font("Consolas", Font.BOLD, 14));
        logArea.setEditable(false);
        logArea.setMargin(new Insets(10, 10, 10, 10));

        statusLabel = new JLabel(" Dang khoi dong Server...");
        statusLabel.setForeground(Color.WHITE);
        statusLabel.setOpaque(true);
        statusLabel.setBackground(new Color(60, 63, 65));
        statusLabel.setPreferredSize(new Dimension(10, 30));

        add(new JScrollPane(logArea), BorderLayout.CENTER);
        add(statusLabel, BorderLayout.SOUTH);

        new Thread(this::startWebSocketServer).start();
    }

    private void startWebSocketServer() {
        // Railway sẽ tự cấp PORT này, không cần thẻ Visa để chạy
        int port = Integer.parseInt(System.getenv().getOrDefault("PORT", "5000"));

        WebSocketServer server = new WebSocketServer(new InetSocketAddress(port)) {
            @Override
            public void onOpen(WebSocket conn, ClientHandshake handshake) {
                updateLog("Ket noi moi: " + conn.getRemoteSocketAddress());
            }

            @Override
            public void onClose(WebSocket conn, int code, String reason, boolean remote) {
                updateLog("Ngat ket noi: " + conn.getRemoteSocketAddress());
            }

            @Override
            public void onMessage(WebSocket conn, String message) {
                String timeStamp = LocalDateTime.now().format(dtf);
                updateLog("[" + timeStamp + "] Tu " + conn.getRemoteSocketAddress() + ": " + message);
                broadcast(message); // Phát tin cho tất cả mọi người online
            }

            @Override
            public void onError(WebSocket conn, Exception ex) {
                updateLog("Loi: " + ex.getMessage());
            }

            @Override
            public void onStart() {
                SwingUtilities.invokeLater(() -> statusLabel.setText(" Server dang chay tai port: " + port));
                updateLog("WebSocket Server da online tren Cloud!");
            }
        };
        server.start();
    }

    private void updateLog(String text) {
        SwingUtilities.invokeLater(() -> {
            logArea.append(text + "\n");
            logArea.setCaretPosition(logArea.getDocument().getLength());
        });
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> new MulticastReceiver().setVisible(true));
    }
}