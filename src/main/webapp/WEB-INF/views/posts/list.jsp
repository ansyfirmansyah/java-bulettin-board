<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.finshot.bulletin.util.DateFormatter" %>
<jsp:include page="../layout/header.jsp" />

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
        <table class="table table-striped">
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
            <c:forEach var="post" items="${posts}">
                <tr>
                    <td>${post.id}</td>
                    <td><a href="<c:url value='/posts/${post.id}'/>">${post.title}</a></td>
                    <td>${post.author}</td>
                    <td>${post.viewCount}</td>
                    <td>${DateFormatter.format(post.createdAt)}</td>
                </tr>
            </c:forEach>
            <c:if test="${empty posts}">
                <tr>
                    <td colspan="5" class="text-center">No posts available</td>
                </tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="../layout/footer.jsp" />