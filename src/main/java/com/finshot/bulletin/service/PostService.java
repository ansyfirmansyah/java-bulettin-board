package com.finshot.bulletin.service;

import com.finshot.bulletin.model.Post;
import java.util.List;

public interface PostService {
    List<Post> getAllPosts();

    Post getPostById(Integer id);

    Post getPostAndIncrementViews(Integer id);

    void createPost(Post post);

    boolean updatePost(Post post, String password);

    boolean deletePost(Integer id, String password);

    boolean isPasswordValid(Integer postId, String password);
}