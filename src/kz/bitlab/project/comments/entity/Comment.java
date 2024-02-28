package kz.bitlab.project.comments.entity;

import kz.bitlab.project.users.entity.User;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Locale;

public class Comment {
    private Long id;
    private String comment;
    private LocalDateTime postDate  = LocalDateTime.now();
    private Long userId;
    private Long newsId;
    private User user;

    public Comment() {
    }

    public Comment(Long id, String comment, LocalDateTime postDate, Long userId, Long newsId) {
        this.id = id;
        this.comment = comment;
        this.postDate = postDate;
        this.userId = userId;
        this.newsId = newsId;
    }

    public Comment(String comment, Long newsId, Long userId) {
        this.comment = comment;
        this.newsId = newsId;
        this.userId = userId;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public LocalDateTime getPostDate() {
        return postDate;
    }

    public void setPostDate(LocalDateTime postDate) {
        this.postDate = postDate;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public User getUser() { return user; }

    public Long getNewsId() {
        return newsId;
    }

    public void setNewsId(Long newsId) {
        this.newsId = newsId;
    }

    public String getFormattedPostDate() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd MMMM yyyy HH:mm").withLocale(Locale.ENGLISH);
        return getPostDate().format(formatter);
    }
}
