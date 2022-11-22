<jsp:directive.page import="java.sql.*" />
<jsp:declaration>
	static String url = "jdbc:mysql://localhost:3306/projetowasabi";
	static String usuario = "root";
	static String senha = "HackSql192022";
	static Connection conexao;
	
	public void init() throws ServletException {
    	try {
	    	conexao = DriverManager.getConnection(url, usuario, senha);
			conexao.setAutoCommit(false);
    	} catch (SQLException e) {
    		e.printStackTrace();
    	}
    }

</jsp:declaration>

<% 

String cpf = request.getParameter("cpf").replaceAll("[-.]", "");
String senha = request.getParameter("senha");

try {
	Statement st = conexao.createStatement();
	ResultSet rs_login = st.executeQuery("SELECT * from loginusuario WHERE cpf_cliente='"+cpf+"' AND senha='"+senha+"'");
	if(rs_login.next()) {
		ResultSet rs_cliente = st.executeQuery("SELECT nome, endereco FROM cliente WHERE cpf='"+cpf+"'");
		rs_cliente.next();
		String nome = rs_cliente.getString("nome");
		String endereco = rs_cliente.getString("endereco");
		session.setAttribute("mensagem", "Autenticado");
		session.setAttribute("login", "true");
		session.setAttribute("nome", nome);
		session.setAttribute("endereco", endereco);
		session.setAttribute("cpf", cpf);
		response.sendRedirect("../index.jsp");
	}else {
		request.getSession().setAttribute("mensagem", "Nao Autenticado");
		session.setAttribute("login", "false");
		response.sendRedirect("../login.jsp");
	}
} catch (SQLException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
}


%>