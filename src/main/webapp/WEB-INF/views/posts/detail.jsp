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

<div class="card">
    <div class="card-header">
        <h3 class="card-title">${post.title}</h3>
        <div class="text-muted">
            By ${post.author} | Views: ${post.viewCount} | Created: ${DateFormatter.format(post.createdAt)}
            <c:if test="${post.updatedAt != null}">
                | Updated: ${DateFormatter.format(post.updatedAt)}
            </c:if>
        </div>
    </div>
    <div class="card-body">
        <p class="card-text">${post.content}</p>
    </div>
    <div class="card-footer">
        <div class="d-flex justify-content-end">
            <a href="<c:url value='/posts/${post.id}/edit'/>" class="btn btn-primary me-2">Edit</a>
            <a href="<c:url value='/posts/${post.id}/delete'/>" class="btn btn-danger">Delete</a>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp" />