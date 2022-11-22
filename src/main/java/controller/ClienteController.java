package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Servlet implementation class ClienteController
 */
public class ClienteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	static String url = "jdbc:mysql://localhost:3306/projetowasabi";
	static String usuario = "root";
	static String senha = "HackSql192022";
	static Connection conexao;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ClienteController() {
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
		if(tipoformulario.equals("cadastro")) {
			/* CADASTRO */
			/********************************************/
			String email = request.getParameter("email");
			String nome = request.getParameter("nome");
			String cpf = request.getParameter("cpf").replaceAll("[-.]", "");
			String telefone = request.getParameter("telefone");
			String senha = request.getParameter("senha");
			String endereco = request.getParameter("endereco");
			String numerocartao = "1010202030304040";
				
			try {
				String cliente_sql = "INSERT INTO cliente VALUES ("+cpf+", '"+nome+"','"+email+"', '"+endereco+"','"+telefone+"','"+numerocartao+"')";
				String login_sql = "INSERT INTO loginusuario VALUES ("+cpf+", '"+senha+"')";
				Statement st = conexao.createStatement();
				st.execute(cliente_sql);
				st.execute(login_sql);
				
				conexao.commit();
				session.setAttribute("mensagem", "");
				response.sendRedirect("login.jsp");
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				session.setAttribute("mensagem", "Cpf Já Cadastrado");
				e.getMessage();
				response.sendRedirect("login.jsp");
			}
		/*********************************************/
		} else if (tipoformulario.equals("alterar")) {
			String cpf = request.getParameter("cpf").replaceAll("[-.]", "");
			String nome = request.getParameter("nome");
			String email = request.getParameter("email");
			String endereco = request.getParameter("endereco");
			String telefone = request.getParameter("telefone");
			String numeroCartao = request.getParameter("numerodecartao");
			
		    try {
		    	String update = "UPDATE cliente SET nome=" + "'" + nome + "'" + "," + "email=" + "'" + email + "'" + "," +"endereco="+ "'" +endereco+ "'" + "," + "telefone="+ "'" + telefone + "'" + "," + "numeroCartao=" + "'" + numeroCartao + "'" + " WHERE cpf="+ "'" + cpf + "'";
		    	System.out.println(update);
				Statement st = conexao.createStatement();
				st.execute(update);
				conexao.commit();
				session = request.getSession();
				session.setAttribute("cpf", cpf);
				session.setAttribute("nome", nome);
				session.setAttribute("email", email);
				session.setAttribute("endereco", endereco);
				session.setAttribute("telefone", telefone);
				session.setAttribute("numeroCartao", numeroCartao);
				response.sendRedirect("index.jsp");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

}
