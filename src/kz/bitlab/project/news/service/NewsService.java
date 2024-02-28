package kz.bitlab.project.news.service;

import kz.bitlab.project.DBManager;
import kz.bitlab.project.news.entity.News;
import kz.bitlab.project.newsCategories.entity.NewsCategory;
import kz.bitlab.project.newsCategories.service.NewsCategoryService;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class NewsService {
    private static final Connection connection = DBManager.getConnection();

    private static News generateNews(ResultSet resultSet) throws SQLException {
        NewsCategory category = NewsCategoryService.findById(resultSet.getLong("category_id"));

        News news = new News();
        news.setId(resultSet.getLong("id"));
        news.setCategory(category);
        news.setPostDate(resultSet.getTimestamp("post_date").toLocalDateTime());
        news.setTitle(resultSet.getString("title"));
        news.setContent(resultSet.getString("content"));

        return news;
    }

    public static List<News> findAll() {
        List<News> newsList = new ArrayList<>();
        try {
            PreparedStatement statement = connection.prepareStatement(
                    "select * from news");
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                News news = generateNews(resultSet);

                newsList.add(news);
            }

            statement.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return newsList;
    }

    public static News findById(Long id) {
        News news = new News();

        try {
            PreparedStatement statement = connection.prepareStatement(
                    "select * from news where id = ?");
            statement.setLong(1, id);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                return generateNews(resultSet);
            }

            statement.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return news;
    }

    public static void create(News news) {
        try{
            PreparedStatement statement = connection.prepareStatement("INSERT INTO news (title, content, category_id, post_date) " +
                    "VALUES (?, ?, ?, ?)"
            );

            statement.setString(1, news.getTitle());
            statement.setString(2, news.getContent());
            statement.setLong(3, news.getCategoryId());
            statement.setTimestamp(4, Timestamp.valueOf(LocalDateTime.now()));

            statement.executeUpdate();

            statement.close();
        } catch (Exception e){
            e.printStackTrace();
        }
    }

    public static void delete(Long id) {
        try {
            PreparedStatement statement = connection.prepareStatement(
                    "delete from news where id = ?");
            statement.setLong(1, id);
            statement.executeUpdate();
            statement.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void update(Long id, Long categoryId, String title, String content) {
        try {
            if (!NewsCategoryService.existsById(categoryId))
                throw new RuntimeException("Category not found");

            PreparedStatement statement = connection.prepareStatement(
                    "update news set category_id = ?, title = ?, content = ? where id =?");
            statement.setLong(1, categoryId);
            statement.setString(2, title);
            statement.setString(3, content);
            statement.setLong(4, id);
            statement.executeUpdate();
            statement.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
