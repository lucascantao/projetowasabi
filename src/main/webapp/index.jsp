<jsp:include page="util/topo.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import ="model.ProdutoDAO"%>
    <%@page import ="java.util.List"%>
     <%@page import ="java.util.ArrayList"%>
   <%@page import="model.Produto" %>
   <%@page import="model.ProdutoSacola" %>
   <%@page import="model.ProdutoSacolaDAO" %>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Wasabi Sushi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/288102535f.js" crossorigin="anonymous"></script>
    <script type="text/javascript" src="script.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.js" integrity="sha512-CX7sDOp7UTAq+i1FYIlf9Uo27x4os+kGeoT7rgwvY+4dmjqV0IuE/Bl5hVsjnQPQiTOhAX1O2r2j5bjsFBvv/A==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  <link rel="stylesheet" type="text/css" href="estilo.css">
    
  </head>
  <body>
<!-- Modal lateral -->

<sql:setDataSource var="bd" 
url="jdbc:mysql://localhost:3306/projetowasabi"
user="root" 
password="HackSql192022"/>
  
  <div class="modal right fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2">
    <div class="modal-dialog" role="document" style="right:-30% !important;">
      <div class="modal-content">

        <div class="modal-header flow">
          <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h5 class="modal-title" id="myModalLabel2">Sacola</h5>
        </div>
        
        <form method="post" action="http://localhost:8080/WassabiAppServer/PedidoController">
        <div class="modal-body">
        <div class="sacola" id="items">

        
        <% 
      List<ProdutoSacola> sacola = new ArrayList<ProdutoSacola>();
	  ProdutoSacolaDAO dao = new ProdutoSacolaDAO();  
	  sacola = ProdutoSacolaDAO.listarSacola();
	  if(sacola == null){
		  System.out.println("Sacola vazia");
	  } else{
      for(ProdutoSacola p: sacola){ 
      %>
        <div class="produto">
        <div class="row">
        <div class="col-md-12"><strong><%= p.getValor() %></strong></div>
        </div>

        <div class="row">
        <div class="col-md-6"><%= p.getNome() %></div>
        <div class="col-md-6"><%= p.getValor() %></div>
        </div>  

        <div class="row">
        <div class="col-md-6"></div>
        <div class="col-md-6"><input class="btn btn-danger" value="Remover" id="<%= p.getProdutoSacolaId() %>" onclick="deletar(id)"></div>
         <input type="hidden" name="<%= p.getProdutoSacolaId() %>" value="" id="hiddenInput">
        </div>  

        </div>   
        <% }
      } %>        
        
        
        </div>        
        </div>
        <input type="hidden" name="tipoformulario" value="produtoSacola">
      <input type="submit" class="btn btn-success full-width" value="Fazer Pedido">   
      </form>

      </div><!-- modal-content -->
    </div><!-- modal-dialog -->
  </div><!-- modal -->

<!-- Modal -->
<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Adicionar Produto</h5>
        <button type="button" class="close" data-bs-dismiss="modal" aria-label="close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">        
       <div class="row">
       <div class="col-md-6">
        <div id="modal-imagem" class="img-modal"><img src="" class="img-geral" /></div>
       </div>
       <div class="col-md-6">
        <div class="formulario-compra">

         <!--<form method="get" action="http://localhost:8089/WassabiAppServer/ServletSacola"> -->

            <div class="input-group mb-3">
            <input type="text" class="form-control border-none background-none" aria-label="Username" readonly value="" id="valor" style="width:100%;">
            <input type="text" class="form-control border-none background-none" aria-label="Username" readonly value="" id="valor2">
            <input type="text" class="form-control border-none background-none" aria-label="Username" readonly value="" id="nome" style="width:100%;">
          </div>
    <!--  PRIMEIRA MODAL PARE AQUI -->
          <div class="input-group flow" style="margin-bottom:5%;">
             <span class="input-group-text border-none background-none">Comentários:</span>
            <textarea class="form-control" aria-label="With textarea" style="width:100%;" placeholder="sem sal, sem cebola e etc"></textarea>
          </div>
           
           <input class="btn btn-dark" id="criarSacola" value="Adicionar à sacola" aria-label="Username" aria-describedby="basic-addon1"></input>
           <input type="hidden" name="produto" value="" id="hiddenInput">
            
         <!-- </form> -->

        </div>
       </div>
       </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fechar</button>
      </div>
    </div>
  </div>
</div>

  <div class="container-fluid d-flex full-height border-gray-light no-margin no-padding flow">


   <!--NAVBAR-->
  <nav class="navbar navbar-expand-lg background-white" style="position: fixed;top: 0;left: 0;right: 0;box-shadow: 2px 2px 5px 5px rgba(238, 237, 237, 0.6); z-index:1000;">
  <a class="navbar-brand" href="index.jsp">Wasabi Sushi</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarText">
    <ul class="navbar-nav mr-auto">
    
    <!-- ---------------------------- ITEM  ------------------------------ -->
      <li class="nav-item active">
        <a class="nav-link" href="">Bem vindo, ${nome}<span class="sr-only">(current)</span></a>
      </li>
    <!-- ---------------------------- ITEM  ------------------------------ -->
    
      
    <!-- ---------------------------- ITEM  ------------------------------ -->

    </ul>
    
      
        <a class="nav-link" href="http://localhost:8080/WassabiAppServer/alteracao.jsp">Editar Perfil<span class="sr-only" style="margin-right:2%">(current)</span></a>
      
     
        <a class="nav-link btn btn-danger" href="" data-bs-toggle="modal" data-bs-target="#myModal2" style="margin-right:2%;"><i class="fa-solid fa-bag-shopping"></i><span class="sr-only">(current)</span></a>
     
    <a href="logout.jsp"><span class="navbar-text">
      Sair
    </span></a>
  </div>
</nav>
  <!--NAVBAR-->

  <!--CONTAINER DA IMAGEM-->
  
  <br/>
  <br/>
  <br/>

  <div class="img-container d-flex justify-content-center align-items-center flow">  

  <div class="imagem-central d-flex">
    
    
  </div>

  

  </div>
  
 <!--CONTAINER DA IMAGEM-->

 <!--GRID PROMOï¿½ï¿½O--->


<sql:query dataSource="${bd}" var="res_cardapio">
SELECT * from cardapio 
</sql:query>

<c:forEach var="cardapio" items="${res_cardapio.rows}">

	<sql:query dataSource="${bd}" var="res_produto">
	SELECT * from produto WHERE tipoProduto=${cardapio.tipo}
	</sql:query>
	
	<div class="promocao-container ">
  	<div class="titulo"><h2>${cardapio.nome}</h2></div>
 	<div class="grid-container no-margin no-padding">
 	
	<c:forEach var="produto" items="${res_produto.rows}">
	
			
 	 				<div class="grid-item grow no-margin no-padding">
	  					<div class="card-components" data-bs-toggle="modal" data-bs-target="#exampleModalCenter" id ="${produto.idProduto}" value="${produto.preco}"onclick="setaModal(id)" >
		   					<div class="grid-item-dsc">
		   						<strong>${produto.nome}</strong><br>
		   						${produto.descricao}<br><br>
		   						Valor: R$${produto.preco}
		   					</div>
		   					<input type="hidden" name="NomeEscondido" value="${produto.nome}" class="hiddenNome">
		    				<div class="grid-promocao-img" value="${produto.urlProduto}">
		    					<img class="img-background-properties" value="${produto.idProduto}" id="imagemProduto" src="${produto.urlProduto}"/>
		    				</div>
	  					</div>
	  				</div>
			<!--  <div><c:out value="${produto.nome}"/> - R$<c:out value="${produto.preco}"/></div> -->		
	</c:forEach>
	
  	</div>
	</div>

</c:forEach>

</div>
  



        <script>
        
        	  $(document).ready(function () {
        		 
                  $('#criarSacola').click(function (event) { 
                	  
                      var nome = $('#nome').val();                    
                      var valor = $('#valor').val();
                      var id = $('#hiddenInput').val();
                      console.log(nome);
                      console.log(valor);
                      console.log(id);
                      var tipoRequisicao = '1';
                      var ativo = '1';
                      $.post('http://localhost:8080/WassabiAppServer/ServletSacola', {valor: valor, id: id, nome: nome, TipoRequisicao : tipoRequisicao, ativo : ativo}, function (responseText) {
                          var items = document.getElementById('items');        
                          items.innerHTML ="";
                          items.innerHTML = responseText;
                      });
                      
                  });

                 
                 
              });

              function deletar(id){
            	 
                  var ProdutoSacolaID = id;
     
                  console.log(ProdutoSacolaID);
                  var tipoRequisicao = '2';
                  $.post('http://localhost:8080/WassabiAppServer/ServletSacola', { ProdutoSacolaID : ProdutoSacolaID, TipoRequisicao : tipoRequisicao}, function (responseText) {
                      if(responseText != null){
                      var div = document.getElementById(id);
                      div.parentElement.parentElement.parentElement.style.display = 'none';
                      }
                  });

                  }
        	  
        </script>

 
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.min.js" integrity="sha384-IDwe1+LCz02ROU9k972gdyvl+AESN10+x7tBKgc9I5HFtuNz0wWnPclzo6p9vxnk" crossorigin="anonymous"></script>
  
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
  </body>
</html>