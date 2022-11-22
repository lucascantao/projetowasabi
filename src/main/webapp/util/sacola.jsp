<%@ taglib 
uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<c:if test="${cpf}">

<sql:setDataSource var="bd" 
url="jdbc:mysql://localhost:3306/projetowasabi"
user="root" 
password="HackSql192022"/>


<sql:query dataSource="${bd}" var="result">
SELECT * from sacola WHERE cpfCliente = ${cpf} 
</sql:query>


<c:forEach var="row" items="${result.rows}">
<div><c:out value="${row.NomeProduto}"/> - R$<c:out value="${row.preco}"/></div>
</c:forEach>

</c:if>

