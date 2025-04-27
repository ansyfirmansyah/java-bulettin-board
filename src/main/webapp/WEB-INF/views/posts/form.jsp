<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="../layout/header.jsp" />

<div class="row mb-3">
    <div class="col">
        <h2>${editMode ? 'Edit Post' : 'Create New Post'}</h2>
    </div>
    <div class="col-auto">
        <a href="<c:url value='/posts'/>" class="btn btn-secondary">Back to List</a>
    </div>
</div>

<div class="card">
    <div class="card-body">
        <c:url var="formAction" value="${editMode ? '/posts/'.concat(post.id).concat('/edit') : '/posts/create'}" />
        <form action="${formAction}" method="post">
            <div class="mb-3">
                <label for="title" class="form-label">Title</label>
                <input type="text" class="form-control" id="title" name="title" value="${post.title}"
                       required maxlength="100">
            </div>
            <div class="mb-3">
                <label for="author" class="form-label">Author</label>
                <input type="text" class="form-control" id="author" name="author" value="${post.author}"
                       required maxlength="10">
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" name="password"
                       required minlength="4">
                <div class="form-text">
                    ${editMode ? 'Enter the password you used when creating this post' : 'You will need this password to edit or delete the post later'}
                </div>
                <c:if test="${param.error == 'password'}">
                    <div class="alert alert-danger mt-2">Incorrect password</div>
                </c:if>
            </div>
            <div class="mb-3">
                <label for="content" class="form-label">Content</label>
                <textarea class="form-control" id="content" name="content"
                          rows="5" required>${post.content}</textarea>
            </div>
            <div class="d-grid">
                <button type="submit" class="btn btn-primary">
                    ${editMode ? 'Update Post' : 'Create Post'}
                </button>
            </div>
        </form>
    </div>
</div>

<jsp:include page="../layout/footer.jsp" />