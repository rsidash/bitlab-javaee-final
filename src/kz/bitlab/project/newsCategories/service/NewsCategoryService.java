package kz.bitlab.project.newsCategories.service;

import kz.bitlab.project.DBManager;
import kz.bitlab.project.newsCategories.entity.NewsCategory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class NewsCategoryService {
    private static final Connection connection = DBManager.getConnection();

    public static NewsCategory findById(Long id) {
        try {
            PreparedStatement statement = connection.prepareStatement(
                    "select * from news_categories where id = ?");
            statement.setLong(1, id);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                NewsCategory category = new NewsCategory();
                category.setId(resultSet.getLong("id"));
                category.setName(resultSet.getString("name"));
                return category;
            }
            statement.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        throw new RuntimeException("Category not found");
    }

    public static List<NewsCategory> findAll() {
        List<NewsCategory> categories = new ArrayList<>();
        try {
            PreparedStatement statement = connection.prepareStatement(
                    "select * from news_categories");
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                NewsCategory category = new NewsCategory();
                category.setId(resultSet.getLong("id"));
                category.setName(resultSet.getString("name"));

                categories.add(category);
            }
            statement.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return categories;
    }
    public static boolean existsById(Long id) {
        boolean isExists = false;
        try {
            PreparedStatement statement = connection.prepareStatement(
                    "select exists(select from news_categories where id = ?)");
            statement.setLong(1, id);
            ResultSet resultSet = statement.executeQuery();
            resultSet.next();

            isExists = resultSet.getBoolean(1);
            statement.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return isExists;
    }

}
