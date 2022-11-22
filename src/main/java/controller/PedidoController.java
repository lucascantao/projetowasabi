package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Produto;
import model.ProdutoDAO;
import model.ProdutoSacola;
import model.ProdutoSacolaDAO;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

/**
 * Servlet implementation class PedidoController
 */
public class PedidoController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static String url = "jdbc:mysql://localhost:3306/projetowasabi";
	static String usuario = "root";
	static String senha = "HackSql192022";
	static Connection conexao;
	HttpSession session;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PedidoController() {
        super();
        // TODO Auto-generated constructor stub
    }
    

    @Override
    public void init() throws ServletException {
    	try {
	    	conexao = DriverManager.getConnection(url, usuario, senha);
			conexao.setAutoCommit(false);
    	} catch (SQLException e) {
    		e.printStackTrace();
    	}
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String tipoformulario = request.getParameter("tipoformulario");
		if(tipoformulario.equals("produtoSacola")) {
		
			List<ProdutoSacola> sacola = new ArrayList<>();
			ProdutoSacolaDAO dao = new ProdutoSacolaDAO();
			double acumulador = 0;
			try {
				sacola = ProdutoSacolaDAO.listarSacola();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		   for(int i = 0; i < sacola.size(); i++) {
			   acumulador = acumulador + Double.parseDouble(sacola.get(i).getNome());
		   }
		   double valorTotal = acumulador;
		   session = request.getSession();
		   session.setAttribute("valorTotal", valorTotal);
		   response.sendRedirect("finalizaPedido.jsp");
		
		} else if (tipoformulario.equals("confirmarpedido")) {
			int id = new Random().nextInt();
			String nome = request.getParameter("nomedocliente");
			String cpfDoCliente = request.getParameter("cpfdocliente");
			
			try {
				String insert1 = "INSERT INTO pedido VALUES ("+id+"," + "'"+cpfDoCliente+"'" + "," + "'"+nome+"'"+")";
				Statement st = conexao.createStatement();
				st.execute(insert1);				
				conexao.commit();
				System.out.println("Pedido feito com sucesso!");
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.getMessage();
				response.sendRedirect("finalizaPedido.jsp");
			}
			   List<Produto> produtosComprados = new ArrayList<>();
		       List<ProdutoSacola> sacola = new ArrayList<>();
		       ProdutoSacolaDAO dao = new ProdutoSacolaDAO();
		       try {
				sacola = ProdutoSacolaDAO.listarSacola();
			} catch (ClassNotFoundException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		       List<Produto> produtos = new ArrayList<>();
		       ProdutoDAO dao2 = new ProdutoDAO();
		       try {
				produtos = ProdutoDAO.listAllProdutos();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		       
		       for(int j = 0; j < sacola.size(); j++){   
		    	   for(int i = 0; i < produtos.size(); i++){
		    		   String nomeSacola = sacola.get(j).getValor();
		    		   String nomeProduto = produtos.get(i).getNome();
		    		   if(nomeSacola.equals(nomeProduto)){
		    			   produtosComprados.add(produtos.get(i));
		    		   }
		    	  
		    	   }
		       }
			int registroAtivo = 0;
			for(Produto p: produtosComprados) {
				int id2 = new Random().nextInt();
				String insert = "INSERT INTO itens_do_pedido values(" + id2 + "," + id + "," + p.getId()+ " )";
				Statement st;
				try {
					st = conexao.createStatement();
					st.execute(insert);
					conexao.commit();
					
					System.out.println("Itens inseridos na itens_do_pedido");
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}
			String desativa = "UPDATE produtos_sacola SET ativo = 0 where ativo = 1";
			try {
				Statement st = conexao.createStatement();
				st.execute(desativa);
				conexao.commit();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			ServletSacola.sacola.clear();
			response.sendRedirect("index.jsp");
		}		
		
	}

}
