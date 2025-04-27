package com.finshot.bulletin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/posts")
public class PostController {

    @GetMapping
    public String getAllPosts() {
        return "posts/list";
    }

    @GetMapping("/{id}")
    public String getPostDetail(@PathVariable Integer id, Model model) {
        model.addAttribute("postId", id);
        return "posts/detail";
    }

    @GetMapping("/create")
    public String createPostForm() {
        return "posts/form";
    }

    @GetMapping("/{id}/edit")
    public String editPostForm(@PathVariable Integer id, Model model) {
        model.addAttribute("postId", id);
        model.addAttribute("editMode", true);
        return "posts/form";
    }

    @GetMapping("/{id}/delete")
    public String deleteConfirmForm(@PathVariable Integer id, Model model) {
        model.addAttribute("postId", id);
        return "posts/delete";
    }
}