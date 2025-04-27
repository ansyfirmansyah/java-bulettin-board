<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.finshot.bulletin.util.DateFormatter" %>
<jsp:include page="../layout/header.jsp" />

<div class="row mb-3">
    <div class="col">
        <h2>Post Detail</h2>
    </div>
    <div class="col-auto">
        <a href="<c:url value='/posts'/>" class="btn btn-secondary">Back to List</a>
    </div>
</div>

<div class="card" id="post-detail">
    <div class="card-header">
        <h3 class="card-title" id="post-title">Loading...</h3>
        <div class="text-muted" id="post-meta">Loading post details...</div>
    </div>
    <div class="card-body">
        <p class="card-text" id="post-content">Loading content...</p>
    </div>
    <div class="card-footer">
        <div class="d-flex justify-content-end">
            <button id="edit-btn" class="btn btn-primary me-2">Edit</button>
            <button id="delete-btn" class="btn btn-danger">Delete</button>
        </div>
    </div>
</div>

<!-- Password Modal for Delete -->
<div class="modal fade" id="passwordModal" tabindex="-1" aria-labelledby="passwordModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="passwordModalLabel">Enter Password</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="passwordForm">
                    <div class="mb-3">
                        <label for="password" class="form-label">Password</label>
                        <input type="password" class="form-control" id="password" required>
                        <div class="form-text">Enter the password you used when creating this post</div>
                        <div id="password-error" class="alert alert-danger mt-2 d-none">Incorrect password</div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-danger" id="confirm-delete-btn">Delete Post</button>
            </div>
        </div>
    </div>
</div>

<script src="<c:url value='/resources/js/api-client.js'/>"></script>
<script>
    // Get post ID from URL
    const postId = window.location.pathname.split('/').pop();

    // Load post details
    async function loadPostDetails() {
        try {
            const response = await apiClient.getPostById(postId);

            if (response.success && response.data) {
                const post = response.data;

                // Update UI with post data
                document.getElementById('post-title').textContent = post.title;

                let metaText = 'Post No. ' + post.id + ' | By ' + post.author + ' | Views: ' + post.viewCount + ' | Created: ' + apiClient.formatDateForDisplay(post.createdAt);
                if (post.updatedAt) {
                    metaText += ` | Updated: ` + apiClient.formatDateForDisplay(post.updatedAt);
                }
                document.getElementById('post-meta').textContent = metaText;

                document.getElementById('post-content').textContent = post.content;

                // Setup button actions
                document.getElementById('edit-btn').onclick = () => {
                    window.location.href = `/posts/` + postId + `/edit`;
                };

                document.getElementById('delete-btn').onclick = () => {
                    document.getElementById('password-error').classList.add('d-none');
                    const modalElement = document.getElementById('passwordModal');
                    modalElement.classList.add('show');
                    modalElement.style.display = 'block';
                    document.body.classList.add('modal-open');
                    // Tambahkan backdrop
                    const backdrop = document.createElement('div');
                    backdrop.className = 'modal-backdrop fade show';
                    document.body.appendChild(backdrop);
                };
            } else {
                // Post not found or error
                document.getElementById('post-title').textContent = 'Post not found';
                document.getElementById('post-meta').textContent = '';
                document.getElementById('post-content').textContent = 'The post you are looking for does not exist or has been deleted.';
                document.querySelector('.card-footer').classList.add('d-none');
            }
        } catch (error) {
            console.error('Failed to load post details:', error);
            document.getElementById('post-title').textContent = 'Error';
            document.getElementById('post-meta').textContent = '';
            document.getElementById('post-content').textContent = 'Failed to load post details. Please try again.';
            document.querySelector('.card-footer').classList.add('d-none');
        }
    }

    // Delete post
    async function deletePost(password) {
        try {
            const response = await apiClient.deletePost(postId, password);

            if (response.success) {
                // Redirect to posts list after successful deletion
                window.location.href = '/posts';
            } else {
                // Show error message
                document.getElementById('password-error').classList.remove('d-none');
            }
        } catch (error) {
            console.error('Failed to delete post:', error);
            document.getElementById('password-error').textContent = 'An error occurred. Please try again.';
            document.getElementById('password-error').classList.remove('d-none');
        }
    }

    // Initialize page
    document.addEventListener('DOMContentLoaded', function() {
        // Load post details
        loadPostDetails();

        // Setup delete confirmation button
        document.getElementById('confirm-delete-btn').addEventListener('click', function() {
            const password = document.getElementById('password').value;
            if (password) {
                deletePost(password);
            }
        });
    });
</script>