<% 
if (session.getAttribute("login") != "true"){
	session.setAttribute("mensagem", "Acesso Proibido! Favor Autenticar");
%>
<jsp:forward page="../login.jsp" />

<% } %>
