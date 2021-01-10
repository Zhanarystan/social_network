package classes;

import java.sql.Timestamp;

public class FriendsRequest {
    private Long id;
    private Long userId;
    private Long requestSenderId;
    private Timestamp sentTime;

    public FriendsRequest(){}

    public FriendsRequest(Long userId, Long requestSenderId) {
        this.userId = userId;
        this.requestSenderId = requestSenderId;
    }

    public FriendsRequest(Long userId, Long requestSenderId, Timestamp sentTime) {
        this.userId = userId;
        this.requestSenderId = requestSenderId;
        this.sentTime = sentTime;
    }

    public FriendsRequest(Long id, Long userId, Long requestSenderId, Timestamp sentTime) {
        this.id = id;
        this.userId = userId;
        this.requestSenderId = requestSenderId;
        this.sentTime = sentTime;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getRequestSenderId() {
        return requestSenderId;
    }

    public void setRequestSenderId(Long requestSenderId) {
        this.requestSenderId = requestSenderId;
    }

    public Timestamp getSentTime() {
        return sentTime;
    }

    public void setSentTime(Timestamp sentTime) {
        this.sentTime = sentTime;
    }
}
