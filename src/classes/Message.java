package classes;

import java.sql.Timestamp;

public class Message {
    private Long id;
    private Chat chat;
    private User user;
    private User sender;
    private String messageText;
    private boolean readByReceiver;
    private Timestamp sentDate;

    public Message(){}

    public Message(Chat chat, User user, User sender, String messageText) {
        this.chat = chat;
        this.user = user;
        this.sender = sender;
        this.messageText = messageText;
    }

    public Message(Chat chat, User user, User sender, String messageText, boolean readByReceiver) {
        this.chat = chat;
        this.user = user;
        this.sender = sender;
        this.messageText = messageText;
        this.readByReceiver = readByReceiver;
    }

    public Message(Chat chat, User user, User sender, String messageText, boolean readByReceiver, Timestamp sentDate) {
        this.chat = chat;
        this.user = user;
        this.sender = sender;
        this.messageText = messageText;
        this.readByReceiver = readByReceiver;
        this.sentDate = sentDate;
    }

    public Message(Long id, Chat chat, User user, User sender, String messageText, boolean readByReceiver, Timestamp sentDate) {
        this.id = id;
        this.chat = chat;
        this.user = user;
        this.sender = sender;
        this.messageText = messageText;
        this.readByReceiver = readByReceiver;
        this.sentDate = sentDate;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Chat getChat() {
        return chat;
    }

    public void setChat(Chat chat) {
        this.chat = chat;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public User getSender() {
        return sender;
    }

    public void setSender(User sender) {
        this.sender = sender;
    }

    public String getMessageText() {
        return messageText;
    }

    public void setMessageText(String messageText) {
        this.messageText = messageText;
    }

    public boolean isReadByReceiver() {
        return readByReceiver;
    }

    public void setReadByReceiver(boolean readByReceiver) {
        this.readByReceiver = readByReceiver;
    }

    public Timestamp getSentDate() {
        return sentDate;
    }

    public void setSentDate(Timestamp sentDate) {
        this.sentDate = sentDate;
    }
}
