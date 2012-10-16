<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="no.bekk.ioskurs.AllPosts" %>
<jsp:include page="includes/top.jsp" />
    <h1>Meldinger</h1>
    <div class="posts">
    <% for (AllPosts.Post post: AllPosts.posts){%>
        <div class="post">
            <div class="from"><%=post.from%></div>
            <div class="date"><%=post.date%></div>
            <div class="message"><%=post.message%></div>
        </div>
    <%}%>
    </div>
<jsp:include page="includes/bottom.jsp" />