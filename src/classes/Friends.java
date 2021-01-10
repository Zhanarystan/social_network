package classes;

import java.sql.Timestamp;

public class Friends {
    private Long id;
    private User user;
    private User friend;
    private Timestamp addedTime;

    public Friends(){}

    public Friends(User user, User friend) {
        this.user = user;
        this.friend = friend;
    }

    public Friends(Long id, User user, User friend, Timestamp addedTime) {
        this.id = id;
        this.user = user;
        this.friend = friend;
        this.addedTime = addedTime;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public User getFriend() {
        return friend;
    }

    public void setFriend(User friend) {
        this.friend = friend;
    }

    public Timestamp getAddedTime() {
        return addedTime;
    }

    public void setAddedTime(Timestamp addedTime) {
        this.addedTime = addedTime;
    }
}
