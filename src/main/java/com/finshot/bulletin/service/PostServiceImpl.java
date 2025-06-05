package com.finshot.bulletin.service;

import com.finshot.bulletin.dao.PostDao;
import com.finshot.bulletin.model.Post;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class PostServiceImpl implements PostService {

    private final PostDao postDao;

    @Autowired
    public PostServiceImpl(PostDao postDao) {
        this.postDao = postDao;
    }

    @Override
    public List<Post> getAllPosts() {
        return postDao.getAllPosts();
    }

    @Override
    public Post getPostById(Integer id) {
        return postDao.getPostById(id);
    }

    @Override
    @Transactional
    public Post getPostAndIncrementViews(Integer id) {
        Post post = postDao.getPostById(id);
        if (post != null) {
            postDao.incrementViewCount(id);
            // Update the local view count to reflect the incrementNonThreadSafe
            post.setViewCount(post.getViewCount() + 1);
        }
        return post;
    }

    @Override
    @Transactional
    public void createPost(Post post) {
        postDao.insertPost(post);
    }

    @Override
    @Transactional
    public boolean updatePost(Post post, String password) {
        if (postDao.checkPassword(post.getId(), password)) {
            postDao.updatePost(post);
            return true;
        }
        return false;
    }

    @Override
    @Transactional
    public boolean deletePost(Integer id, String password) {
        if (postDao.checkPassword(id, password)) {
            postDao.deletePost(id);
            return true;
        }
        return false;
    }

    @Override
    public boolean isPasswordValid(Integer postId, String password) {
        return postDao.checkPassword(postId, password);
    }
}