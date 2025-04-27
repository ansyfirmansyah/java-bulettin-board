package com.finshot.bulletin.dao;

import com.finshot.bulletin.model.Post;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface PostDao {
    // Mendapatkan semua post yang tidak dihapus
    List<Post> getAllPosts();

    // Mendapatkan post berdasarkan ID
    Post getPostById(Integer id);

    // Menambahkan post baru
    void insertPost(Post post);

    // Mengupdate post yang sudah ada
    void updatePost(Post post);

    // Soft delete post (set is_deleted = true)
    void deletePost(Integer id);

    // Memperbarui view count
    void incrementViewCount(Integer id);

    // Memeriksa password
    boolean checkPassword(@Param("id") Integer id, @Param("password") String password);
}