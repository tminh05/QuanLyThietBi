package multicast_maven;

import org.java_websocket.client.WebSocketClient;
import org.java_websocket.handshake.ServerHandshake;
import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.net.URI;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class MulticastSender extends JFrame {
    private JTextField inputField;
    private JTextArea historyArea;
    private JLabel statusLabel;
    private MyWebSocketClient client;
    private final DateTimeFormatter dtf = DateTimeFormatter.ofPattern("HH:mm:ss");

    public MulticastSender() {
        setTitle("🚀 CLOUD CLIENT - GUI TIN 🚀");
        setSize(500, 400);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        setLocationRelativeTo(null);
        getContentPane().setBackground(new Color(25, 25, 25));

        inputField = new JTextField();
        JButton sendButton = new JButton("GUI LEN CLOUD");
        historyArea = new JTextArea();
        historyArea.setEditable(false);
        historyArea.setBackground(new Color(25, 25, 25));
        historyArea.setForeground(new Color(57, 255, 20));

        statusLabel = new JLabel(" Dang ket noi den Cloud...");
        statusLabel.setForeground(Color.WHITE);
        statusLabel.setOpaque(true);
        statusLabel.setBackground(new Color(45, 45, 45));

        JPanel topPanel = new JPanel(new BorderLayout(5, 5));
        topPanel.add(inputField, BorderLayout.CENTER);
        topPanel.add(sendButton, BorderLayout.EAST);

        add(topPanel, BorderLayout.NORTH);
        add(new JScrollPane(historyArea), BorderLayout.CENTER);
        add(statusLabel, BorderLayout.SOUTH);

        initWebSocket();

        sendButton.addActionListener(this::sendMessage);
        inputField.addActionListener(this::sendMessage);
    }

    private void initWebSocket() {
        try {
            // SAU KHI DEPLOY, THAY localhost THANH URL CUA RAILWAY
            String serverUrl = "ws://localhost:5000"; 
            client = new MyWebSocketClient(new URI(serverUrl));
            client.connect();
        } catch (Exception e) {
            historyArea.append("Loi ket noi: " + e.getMessage() + "\n");
        }
    }

    private class MyWebSocketClient extends WebSocketClient {
        public MyWebSocketClient(URI serverUri) { super(serverUri); }
        @Override
        public void onOpen(ServerHandshake hand) {
            SwingUtilities.invokeLater(() -> statusLabel.setText(" DA KET NOI CLOUD"));
        }
        @Override
        public void onMessage(String msg) {
            SwingUtilities.invokeLater(() -> {
                historyArea.append("[" + LocalDateTime.now().format(dtf) + "] NHAN: " + msg + "\n");
            });
        }
        @Override public void onClose(int c, String r, boolean rem) {}
        @Override public void onError(Exception ex) {}
    }

    private void sendMessage(ActionEvent e) {
        String msg = inputField.getText().trim();
        if (!msg.isEmpty() && client.isOpen()) {
            client.send(msg);
            inputField.setText("");
        }
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> new MulticastSender().setVisible(true));
    }
}