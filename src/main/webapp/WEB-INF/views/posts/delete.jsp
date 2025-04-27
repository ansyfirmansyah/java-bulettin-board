<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../layout/header.jsp" />

<div class="row mb-3">
  <div class="col">
    <h2>Delete Post</h2>
  </div>
  <div class="col-auto">
    <a href="<c:url value='/posts/${post.id}'/>" class="btn btn-secondary">Back to Post</a>
  </div>
</div>

<div class="card">
  <div class="card-body">
    <h5 class="card-title">Are you sure you want to delete this post?</h5>
    <p><strong>Title:</strong> ${post.title}</p>
    <p><strong>Author:</strong> ${post.author}</p>

    <form action="<c:url value='/posts/${post.id}/delete'/>" method="post">
      <div class="mb-3">
        <label for="password" class="form-label">Password</label>
        <input type="password" class="form-control" id="password" name="password" required>
        <div class="form-text">Enter the password you used when creating this post</div>
        <c:if test="${param.error == 'password'}">
          <div class="alert alert-danger mt-2">Incorrect password</div>
        </c:if>
      </div>
      <div class="d-flex justify-content-between">
        <a href="<c:url value='/posts/${post.id}'/>" class="btn btn-secondary">Cancel</a>
        <button type="submit" class="btn btn-danger">Delete Post</button>
      </div>
    </form>
  </div>
</div>

<jsp:include page="../layout/footer.jsp" />