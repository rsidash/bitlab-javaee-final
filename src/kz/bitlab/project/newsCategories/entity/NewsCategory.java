package kz.bitlab.project.newsCategories.entity;

public class NewsCategory {
    private Long id;
    private String name;

    public NewsCategory() {
    }

    public NewsCategory(String name) {
        this.name = name;
    }

    public NewsCategory(Long id, String name) {
        this.id = id;
        this.name = name;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
