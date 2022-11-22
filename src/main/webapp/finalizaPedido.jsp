<jsp:include page="util/topo.jsp" />
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
    <title>FinalizarPedido</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/288102535f.js" crossorigin="anonymous"></script>
    <script type="text/javascript" src="script.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.js" integrity="sha512-CX7sDOp7UTAq+i1FYIlf9Uo27x4os+kGeoT7rgwvY+4dmjqV0IuE/Bl5hVsjnQPQiTOhAX1O2r2j5bjsFBvv/A==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  </head>
  <link rel="stylesheet" type="text/css" href="estilo.css">
  <body>
  
  
      <!--NAVBAR-->
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

  <!--/NAVBAR-->
	<br><br><br><br>
    <div class="container-fluid viewport d-flex align-items-center justify-content-center flow">
    <h1> Finalizar Pedido </h1>
    <div class="pedido-container flow">
    <form class="form-control d-flex size flow" method="post" action="http://localhost:8080/WassabiAppServer/PedidoController">
    <div class="formulario-pedido flow">
    <div class="row flow no-margin">
    <div class="col-md-12 d-flex align-items-center justify-content-start  fit-size">Cliente:<strong> <%= session.getAttribute("nome") %></strong></div>  
    <input type="hidden" class="form-control border-none background-none" aria-label="Username" readonly value="<%= session.getAttribute("nome") %>" name="nomedocliente">
    <input type="hidden" class="form-control border-none background-none" aria-label="Username" readonly value="<%= session.getAttribute("cpf") %>" name="cpfdocliente">
    </div>  

    <div class="row flow no-margin">
    <div class="col-md-12 d-flex align-items-center justify-content-start fit-size">Endereço: <strong><%= session.getAttribute("endereco") %></strong> </div>  
     <input type="hidden" class="form-control border-none background-none" aria-label="Username" readonly value="<%= session.getAttribute("endereco") %>" name="enderecodocliente">
    </div>  

    <div class="row flow no-margin">
    <% 
       List<Produto> produtosComprados = new ArrayList<>();
       List<ProdutoSacola> sacola = new ArrayList<>();
       ProdutoSacolaDAO dao = new ProdutoSacolaDAO();
       sacola = ProdutoSacolaDAO.listarSacola();
       List<Produto> produtos = new ArrayList<>();
       ProdutoDAO dao2 = new ProdutoDAO();
       produtos = ProdutoDAO.listAllProdutos();
       
       for(int j = 0; j < sacola.size(); j++){   
       for(int i = 0; i < produtos.size(); i++){
       String nomeSacola = sacola.get(j).getValor();
       String nomeProduto = produtos.get(i).getNome();
       System.out.println(nomeSacola);
       System.out.println(nomeProduto);
       if(nomeSacola.equals(nomeProduto)){
    	   
    	   produtosComprados.add(produtos.get(i));
       }
    	  
       }
       }
       
       for(Produto p: produtosComprados){
    %>
    <div class="col-md-3 d-flex align-items-center justify-content-start  fit-size">Produto: <%= p.getNome() %></div>
    <input type="hidden" class="form-control border-none background-none" value="<%= p.getNome() %>" name="nomedoproduto">
    <input type="hidden" class="form-control border-none background-none" aria-label="Username" readonly value="<%= p.getId() %>" name="idDoProduto">
    <div class="col-md-3 d-flex align-items-center justify-content-start fit-size"> Valor: <%= p.getPreco() %> R$ </div>
     <input type="hidden" class="form-control border-none background-none" value="<%= p.getPreco() %>" name="nomedoproduto">
    <div class="col-md-3 d-flex align-items-center justify-content-start  fit-size" >Descrição:  <%= p.getDescricao() %></div>
    <% } %>
    <div class="col-md-3 d-flex align-items-center justify-content-start  fit-size" >Valor Total: <%= session.getAttribute("valorTotal") %></div>
    </div>  

   </div>
   
   <div class="botoes fit-size">
    <input type="submit" class="btn btn-dark d-flex fit-size" aria-label="Username" readonly value="confirmarpedido" name="tipoformulario" style="margin-right:2%;">
    <a href="index.jsp" class="btn btn-dark d-flex fit-size" aria-label="Username" style="margin-left:2%;">Voltar a loja</a> 
    
  </div>
  
     </form>
    </div>
  
    </div>  
     


     
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.min.js" integrity="sha384-IDwe1+LCz02ROU9k972gdyvl+AESN10+x7tBKgc9I5HFtuNz0wWnPclzo6p9vxnk" crossorigin="anonymous"></script>

  </body>
</html>
    