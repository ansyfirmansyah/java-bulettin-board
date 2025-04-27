<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.finshot.bulletin.util.DateFormatter" %>
<jsp:include page="../layout/header.jsp"/>

<div class="row mb-3">
    <div class="col">
        <h2>Posts List</h2>
    </div>
    <div class="col-auto">
        <a href="<c:url value='/posts/create'/>" class="btn btn-primary">Create New Post</a>
    </div>
</div>

<div class="card">
    <div class="card-body">
        <table class="table table-striped" id="postsTable">
            <thead>
            <tr>
                <th>#</th>
                <th>Title</th>
                <th>Author</th>
                <th>Views</th>
                <th>Created Date</th>
            </tr>
            </thead>
            <tbody>
            <!-- Posts will be loaded dynamically -->
            <tr>
                <td colspan="5" class="text-center">Loading posts...</td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<script src="<c:url value='/resources/js/api-client.js'/>"></script>
<script>
    // Load posts when the page loads
    document.addEventListener('DOMContentLoaded', async function () {
        try {
            const response = await apiClient.getAllPosts();
            console.log("API Response:", response);
            const postsTableBody = document.querySelector('#postsTable tbody');

            if (response.success && response.data && response.data.length > 0) {
                console.log("Posts data:", response.data);
                // Clear the loading message
                postsTableBody.innerHTML = '';

                // Add posts to the table
                response.data.forEach(post => {
                    console.log("Processing post:", post);
                    postsTableBody.innerHTML +=
                        '<tr>' +
                        '<td>' + (post.id || '') + '</td>' +
                        '<td><a href="/posts/' + (post.id || '') + '">' + (post.title || '') + '</a></td>' +
                        '<td>' + (post.author || '') + '</td>' +
                        '<td>' + (post.viewCount || 0) + '</td>' +
                        '<td>' + apiClient.formatDateForDisplay(post.createdAt) + '</td>' +
                        '</tr>';
                });
            } else {
                postsTableBody.innerHTML = '<tr><td colspan="5" class="text-center">No posts available</td></tr>';
            }
        } catch (error) {
            console.error('Failed to load posts:', error);
            document.querySelector('#postsTable tbody').innerHTML =
                '<tr><td colspan="5" class="text-center text-danger">Failed to load posts. Please try again.</td></tr>';
        }
    });
</script>

<jsp:include page="../layout/footer.jsp"/>