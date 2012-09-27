<%@ page import="no.bekk.ioskurs.AllPosts" %>
<html>
<head>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<div class="content">
    <% for (AllPosts.Post post: AllPosts.posts){%>
         <article>
             <from><%=post.from%></from>
             <message><%=post.message%></message>
         </article>
    <%}%>
</div>
</body>
</html>