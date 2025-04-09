package pk;

import java.io.IOException;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


/**
 * Servlet implementation class LoginAuthenticator
 */
@WebServlet("/LogAuth")
public class LogAuth extends HttpServlet {
	private static final long serialVersionUID = 2L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LogAuth() {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("./index.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		beanDB db = new beanDB();
		boolean okdb = false;
		HttpSession session = request.getSession();
		String usuario=request.getParameter("usuario");
		String pass=request.getParameter("pass");
		if (usuario == null) usuario="";
		if (pass == null) pass="";
		boolean ok=false;
		
		try {
			db.conectarBD();
			okdb = true;
		} catch (Exception e) {
			okdb = false;
			e.printStackTrace();
		}
		
		if (okdb) {
			String query = "SELECT USERID FROM USERS WHERE USERNAME = '" + usuario + "' AND PASSWORD = AES_ENCRYPT('" + pass +  "','CLAVEAQUI')";
			String[][] tabla = null;
			try {
				tabla = db.resConsultaSelectA3(query);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if (tabla != null) {
				session.setAttribute("attributo2",usuario);
				session.setAttribute("attributo1","1");
				ok=true;
			}
			db.desconectarBD();
		}
				
		if (ok) response.sendRedirect("index.jsp");
		else response.sendRedirect("index.jsp");

	}


}
