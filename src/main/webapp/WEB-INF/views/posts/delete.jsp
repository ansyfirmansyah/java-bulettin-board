<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../layout/header.jsp" />

<div class="row mb-3">
  <div class="col">
    <h2>Delete Post</h2>
  </div>
  <div class="col-auto">
    <a href="#" class="btn btn-secondary" id="back-btn">Back to Post</a>
  </div>
</div>

<div class="card">
  <div class="card-body">
    <h5 class="card-title">Are you sure you want to delete this post?</h5>
    <p><strong>Title:</strong> <span id="post-title">Loading...</span></p>
    <p><strong>Author:</strong> <span id="post-author">Loading...</span></p>

    <form id="deleteForm">
      <div class="mb-3">
        <label for="password" class="form-label">Password</label>
        <input type="password" class="form-control" id="password" name="password" required>
        <div class="form-text">Enter the password you used when creating this post</div>
        <div id="password-error" class="alert alert-danger mt-2 d-none">Incorrect password</div>
      </div>
      <div class="d-flex justify-content-between">
        <button type="button" class="btn btn-secondary" id="cancel-btn">Cancel</button>
        <button type="submit" class="btn btn-danger">Delete Post</button>
      </div>
    </form>
  </div>
</div>

<script src="<c:url value='/resources/js/api-client.js'/>"></script>
<script>
  // Get post ID from URL
  const postId = window.location.pathname.split('/').filter(segment => segment)[1];

  // Load post details
  async function loadPostDetails() {
    try {
      const response = await apiClient.getPostById(postId);

      if (response.success && response.data) {
        const post = response.data;

        // Update UI with post data
        document.getElementById('post-title').textContent = post.title;
        document.getElementById('post-author').textContent = post.author;

        // Set back and cancel buttons URLs
        document.getElementById('back-btn').href = `/posts/` + postId;
        document.getElementById('cancel-btn').onclick = () => {
          window.location.href = `/posts/` + postId;
        };
      } else {
        // Post not found or error
        alert('Post not found or has been deleted.');
        window.location.href = '/posts';
      }
    } catch (error) {
      console.error('Failed to load post details:', error);
      alert('Failed to load post details. Please try again.');
      window.location.href = '/posts';
    }
  }

  // Handle form submission
  async function handleSubmit(event) {
    event.preventDefault();

    const password = document.getElementById('password').value;

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

    // Setup form submission handler
    document.getElementById('deleteForm').addEventListener('submit', handleSubmit);
  });
</script>

<jsp:include page="../layout/footer.jsp" />