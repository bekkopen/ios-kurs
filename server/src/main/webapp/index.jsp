<%@page contentType="text/html;charset=UTF-8" %>
<jsp:include page="includes/top.jsp" />
    <h1>iOS kurs</h1>

    <p>
        Post med url params <strong>from</strong> og <strong>message</strong> til <a href="/post">/post</a> for å legge
        til beskjed på boarden (f.eks. /post?from=Cantona&message=Seagulls)
    </p>

    <p>
        Besøk <a href="/json">/json</a> for å få alle poster som json
    </p>

    <p>
        Besøk <a href="/allposts.jsp">/allposts.jsp</a> for å se alle poster som HTML
    </p>

    <p>
        Eller <a href="/clear">Slett alle poster</a>
    </p>

<jsp:include page="includes/bottom.jsp" />