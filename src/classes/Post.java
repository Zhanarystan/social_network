package classes;

import java.sql.Timestamp;

public class Post {
    private Long id;
    private User author;
    private String title;
    private String shortContent;
    private String content;
    private Timestamp postDate;

    public Post(){}

    public Post(String title, String shortContent, String content, Timestamp postDate) {
        this.title = title;
        this.shortContent = shortContent;
        this.content = content;
        this.postDate = postDate;
    }

    public Post(User author, String title, String shortContent, String content) {
        this.author = author;
        this.title = title;
        this.shortContent = shortContent;
        this.content = content;
    }

    public Post(Long id, User author, String title, String shortContent, String content, Timestamp postDate) {
        this.id = id;
        this.author = author;
        this.title = title;
        this.shortContent = shortContent;
        this.content = content;
        this.postDate = postDate;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public User getAuthor() {
        return author;
    }

    public void setAuthor(User author) {
        this.author = author;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getShortContent() {
        return shortContent;
    }

    public void setShortContent(String shortContent) {
        this.shortContent = shortContent;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Timestamp getPostDate() {
        return postDate;
    }

    public void setPostDate(Timestamp postDate) {
        this.postDate = postDate;
    }
}
