package com.finshot.bulletin.controller;

import com.finshot.bulletin.model.Post;
import com.finshot.bulletin.service.PostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/posts")
public class PostController {

    private final PostService postService;

    @Autowired
    public PostController(PostService postService) {
        this.postService = postService;
    }

    // Halaman list semua post
    @GetMapping
    public String getAllPosts(Model model) {
        model.addAttribute("posts", postService.getAllPosts());
        return "posts/list";
    }

    // Halaman detail post
    @GetMapping("/{id}")
    public String getPostDetail(@PathVariable Integer id, Model model) {
        Post post = postService.getPostAndIncrementViews(id);
        if (post == null) {
            return "redirect:/posts";
        }
        model.addAttribute("post", post);
        return "posts/detail";
    }

    // Halaman form create post
    @GetMapping("/create")
    public String createPostForm(Model model) {
        model.addAttribute("post", new Post());
        return "posts/form";
    }

    // Proses create post
    @PostMapping("/create")
    public String createPost(@ModelAttribute Post post) {
        postService.createPost(post);
        return "redirect:/posts";
    }

    // Halaman form edit post
    @GetMapping("/{id}/edit")
    public String editPostForm(@PathVariable Integer id, Model model) {
        Post post = postService.getPostById(id);
        if (post == null) {
            return "redirect:/posts";
        }
        model.addAttribute("post", post);
        model.addAttribute("editMode", true);
        return "posts/form";
    }

    // Proses edit post
    @PostMapping("/{id}/edit")
    public String editPost(@PathVariable Integer id,
                           @ModelAttribute Post post,
                           @RequestParam String password) {
        post.setId(id);
        boolean success = postService.updatePost(post, password);
        if (!success) {
            return "redirect:/posts/" + id + "/edit?error=password";
        }
        return "redirect:/posts/" + id;
    }

    // Halaman konfirmasi delete post
    @GetMapping("/{id}/delete")
    public String deleteConfirmForm(@PathVariable Integer id, Model model) {
        Post post = postService.getPostById(id);
        if (post == null) {
            return "redirect:/posts";
        }
        model.addAttribute("post", post);
        return "posts/delete";
    }

    // Proses delete post
    @PostMapping("/{id}/delete")
    public String deletePost(@PathVariable Integer id,
                             @RequestParam String password) {
        boolean success = postService.deletePost(id, password);
        if (!success) {
            return "redirect:/posts/" + id + "/delete?error=password";
        }
        return "redirect:/posts";
    }
}