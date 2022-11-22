package controller;

import java.util.ArrayList;
import java.util.List;

import model.Produto;


import jakarta.servlet.ServletConfig;
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
 * Servlet implementation class Autenticacao
 */
public class Sacola extends HttpServlet {
	private static final long serialVersionUID = 1L;
    static String url = "jdbc:mysql://localhost:3306/projetowasabi";
    static String usuario = "root";
    static String senha = "HackSql192022";
    static Connection conexao; 
    static boolean autenticado = false;
    static List<Produto> sacola = new ArrayList<>();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Sacola() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    
    public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		System.out.println("Iniciando os serviços...");
		try {
	    Class.forName("com.mysql.jdbc.Driver");
		conexao = DriverManager.getConnection(url,usuario,senha);
		conexao.setAutoCommit(false);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String id = request.getParameter("produto");
		String consulta = "SELECT * FROM PRODUTO WHERE idProduto="+id;
		Statement st;
		try {
			st = conexao.createStatement();
			ResultSet rs = st.executeQuery(consulta);
			while(rs.next()) {
			int primaryKey = rs.getInt(1);
			String nome = rs.getString(2);
			double preco = rs.getDouble(3);
			String descricao = rs.getString(4);
			int tipoProduto = rs.getInt(5);
			String url = rs.getString(6);
			Produto novoProduto = new Produto(primaryKey,nome,preco,descricao,tipoProduto,url);
			sacola.add(novoProduto);
			sacola.forEach(produto-> System.out.println(produto.getNome()));
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		HttpSession session = request.getSession();
		session.setAttribute("sacola", sacola);
		/*HttpSession session = request.getSession();*/
		/*autenticado = (boolean) session.getAttribute("autenticado");*/
	}
	
	/*protected boolean autenticacao(String cpf, String senha) {
		String consulta = "SELECT * FROM LOGIN where cpf='"+cpf+"'";
		Statement st;
		
		try {
			st = conexao.createStatement();
			ResultSet rs = st.executeQuery(consulta);
			if(rs.next()) {
				return true;
			} else {
				return false;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return false;
		
		
	}*/
}

