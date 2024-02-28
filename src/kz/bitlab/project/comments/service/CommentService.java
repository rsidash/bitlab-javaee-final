package kz.bitlab.project.comments.service;

import kz.bitlab.project.DBManager;
import kz.bitlab.project.comments.entity.Comment;
import kz.bitlab.project.users.entity.User;
import kz.bitlab.project.users.service.UserService;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class CommentService {
    private static final Connection connection = DBManager.getConnection();

    public static List<Comment> findByNewsId(Long newsId) {
        List<Comment> commentList = new ArrayList<>();

        try {
            PreparedStatement statement = connection.prepareStatement(
                    "select * from comments where news_id = ?");
            statement.setLong(1, newsId);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                Comment comment = new Comment();
                User user = UserService.findById(resultSet.getLong("user_id"));

                comment.setId(resultSet.getLong("id"));
                comment.setComment(resultSet.getString("comment"));
                comment.setPostDate(resultSet.getTimestamp("post_date").toLocalDateTime());
                comment.setNewsId(resultSet.getLong("news_id"));
                comment.setUser(user);

                commentList.add(comment);
            }

            statement.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return commentList;
    }

    public static void create(Comment comment) {
        try{
            PreparedStatement statement = connection.prepareStatement("INSERT INTO comments (comment, news_id, user_id, post_date) " +
                    "VALUES (?, ?, ?, ?)"
            );

            statement.setString(1, comment.getComment());
            statement.setLong(2, comment.getNewsId());
            statement.setLong(3, comment.getUserId());
            statement.setTimestamp(4, Timestamp.valueOf(LocalDateTime.now()));

            statement.executeUpdate();

            statement.close();
        } catch (Exception e){
            e.printStackTrace();
        }
    }
}
