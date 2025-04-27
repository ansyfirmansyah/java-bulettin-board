package com.finshot.bulletin.controller.api;

import com.finshot.bulletin.dto.ApiResponse;
import com.finshot.bulletin.dto.PostDTO;
import com.finshot.bulletin.dto.PasswordRequest;
import com.finshot.bulletin.model.Post;
import com.finshot.bulletin.service.PostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/posts")
@CrossOrigin(origins = "*")
public class PostRestController {

    private final PostService postService;

    @Autowired
    public PostRestController(PostService postService) {
        this.postService = postService;
    }

    @GetMapping
    public ResponseEntity<ApiResponse<List<PostDTO>>> getAllPosts() {
        List<PostDTO> posts = postService.getAllPosts().stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());

        return ResponseEntity.ok(new ApiResponse<>(true, "Posts retrieved successfully", posts));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<PostDTO>> getPostById(@PathVariable Integer id) {
        Post post = postService.getPostAndIncrementViews(id);
        if (post == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(new ApiResponse<>(false, "Post not found", null));
        }

        return ResponseEntity.ok(new ApiResponse<>(true, "Post retrieved successfully", convertToDTO(post)));
    }

    @PostMapping
    public ResponseEntity<ApiResponse<PostDTO>> createPost(@RequestBody PostDTO postDTO) {
        Post post = convertToEntity(postDTO);
        postService.createPost(post);

        return ResponseEntity.status(HttpStatus.CREATED)
                .body(new ApiResponse<>(true, "Post created successfully", convertToDTO(post)));
    }

    @PutMapping("/{id}")
    public ResponseEntity<ApiResponse<PostDTO>> updatePost(
            @PathVariable Integer id,
            @RequestBody PostDTO postDTO) {

        Post post = convertToEntity(postDTO);
        post.setId(id);

        boolean success = postService.updatePost(post, postDTO.getPassword());
        if (!success) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(new ApiResponse<>(false, "Invalid password", null));
        }

        Post updatedPost = postService.getPostById(id);
        return ResponseEntity.ok(new ApiResponse<>(true, "Post updated successfully", convertToDTO(updatedPost)));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<ApiResponse<Void>> deletePost(
            @PathVariable Integer id,
            @RequestBody PasswordRequest passwordRequest) {

        boolean success = postService.deletePost(id, passwordRequest.getPassword());
        if (!success) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(new ApiResponse<>(false, "Invalid password", null));
        }

        return ResponseEntity.ok(new ApiResponse<>(true, "Post deleted successfully", null));
    }

    @PostMapping("/{id}/verify-password")
    public ResponseEntity<ApiResponse<Boolean>> verifyPassword(
            @PathVariable Integer id,
            @RequestBody PasswordRequest passwordRequest) {

        boolean valid = postService.isPasswordValid(id, passwordRequest.getPassword());
        return ResponseEntity.ok(new ApiResponse<>(true, valid ? "Password valid" : "Password invalid", valid));
    }

    // Helper method untuk konversi DTO ke entity
    private PostDTO convertToDTO(Post post) {
        PostDTO dto = new PostDTO();
        dto.setId(post.getId());
        dto.setTitle(post.getTitle());
        dto.setAuthor(post.getAuthor());
        dto.setContent(post.getContent());
        dto.setViewCount(post.getViewCount());
        dto.setCreatedAt(post.getCreatedAt());
        dto.setUpdatedAt(post.getUpdatedAt());
        // Password tidak ditambahkan di DTO untuk keamanan
        return dto;
    }

    private Post convertToEntity(PostDTO dto) {
        Post post = new Post();
        post.setId(dto.getId());
        post.setTitle(dto.getTitle());
        post.setAuthor(dto.getAuthor());
        post.setPassword(dto.getPassword());
        post.setContent(dto.getContent());
        post.setViewCount(dto.getViewCount());
        post.setCreatedAt(dto.getCreatedAt());
        post.setUpdatedAt(dto.getUpdatedAt());
        return post;
    }
}