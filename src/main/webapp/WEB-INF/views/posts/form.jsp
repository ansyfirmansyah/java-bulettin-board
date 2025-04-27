<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../layout/header.jsp" />

<div class="row mb-3">
    <div class="col">
        <h2 id="form-title">Loading...</h2>
    </div>
    <div class="col-auto">
        <a href="<c:url value='/posts'/>" class="btn btn-secondary">Back to List</a>
    </div>
</div>

<div class="card">
    <div class="card-body">
        <form id="postForm">
            <div class="mb-3">
                <label for="title" class="form-label">Title</label>
                <input type="text" class="form-control" id="title" name="title" required maxlength="100">
            </div>
            <div class="mb-3">
                <label for="author" class="form-label">Author</label>
                <input type="text" class="form-control" id="author" name="author" required maxlength="10">
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" name="password" required minlength="4">
                <div class="form-text" id="password-help">
                    You will need this password to edit or delete the post later
                </div>
                <div id="password-error" class="alert alert-danger mt-2 d-none">Incorrect password</div>
            </div>
            <div class="mb-3">
                <label for="content" class="form-label">Content</label>
                <textarea class="form-control" id="content" name="content" rows="5" required></textarea>
            </div>
            <div class="d-grid">
                <button type="submit" class="btn btn-primary" id="submit-btn">
                    Submit
                </button>
            </div>
        </form>
    </div>
</div>

<script src="<c:url value='/resources/js/api-client.js'/>"></script>
<script>
    // Get URL path segments
    const pathSegments = window.location.pathname.split('/').filter(segment => segment);
    const isEditMode = pathSegments.includes('edit');
    const postId = isEditMode ? pathSegments[pathSegments.length - 2] : null;

    // Update UI based on mode
    document.getElementById('form-title').textContent = isEditMode ? 'Edit Post' : 'Create New Post';
    document.getElementById('submit-btn').textContent = isEditMode ? 'Update Post' : 'Create Post';

    if (isEditMode) {
        document.getElementById('password-help').textContent = 'Enter the password you used when creating this post';
    }

    // Load post data in edit mode
    async function loadPostData() {
        if (!isEditMode) return;

        try {
            const response = await apiClient.getPostById(postId);

            if (response.success && response.data) {
                const post = response.data;

                // Fill form with post data
                document.getElementById('title').value = post.title;
                document.getElementById('author').value = post.author;
                document.getElementById('content').value = post.content;

                // Password is not returned from API for security reasons
            } else {
                alert('Post not found or has been deleted.');
                window.location.href = '/posts';
            }
        } catch (error) {
            console.error('Failed to load post data:', error);
            alert('Failed to load post data. Please try again.');
            window.location.href = '/posts';
        }
    }

    // Handle form submission
    async function handleSubmit(event) {
        event.preventDefault();

        // Get form data
        const formData = {
            title: document.getElementById('title').value,
            author: document.getElementById('author').value,
            password: document.getElementById('password').value,
            content: document.getElementById('content').value
        };

        try {
            let response;

            if (isEditMode) {
                // Update existing post
                response = await apiClient.updatePost(postId, formData);
            } else {
                // Create new post
                response = await apiClient.createPost(formData);
            }

            if (response.success) {
                // Redirect after successful submission
                const redirectId = isEditMode ? postId : response.data.id;
                window.location.href = `/posts/` + redirectId;
            } else {
                // Handle error
                if (response.message && response.message.includes('password')) {
                    document.getElementById('password-error').textContent = 'Incorrect password';
                    document.getElementById('password-error').classList.remove('d-none');
                } else {
                    alert('An error occurred: ' + response.message);
                }
            }
        } catch (error) {
            console.error('Form submission failed:', error);
            alert('An error occurred while submitting the form. Please try again.');
        }
    }

    // Initialize page
    document.addEventListener('DOMContentLoaded', function() {
        // Load post data in edit mode
        if (isEditMode) {
            loadPostData();
        }

        // Setup form submission handler
        document.getElementById('postForm').addEventListener('submit', handleSubmit);
    });
</script>

<jsp:include page="../layout/footer.jsp" />