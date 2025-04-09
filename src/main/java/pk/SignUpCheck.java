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
@WebServlet("/SignUpCheck")
public class SignUpCheck extends HttpServlet {
	private static final long serialVersionUID = 4L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SignUpCheck() {
        super();
        // TODO Auto-generated constructor stub
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("./index.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		beanDB db = new beanDB();
		boolean okdb = false;
		HttpSession session = request.getSession();
		String usuario=request.getParameter("usuario");
		String pass=request.getParameter("pass");
		String mail=request.getParameter("recovery");
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
			String insertQuery = "INSERT INTO USERS (USERNAME, PASSWORD, RECOVERY_ADDRESS) VALUES ('" + usuario + "', AES_ENCRYPT('" + pass +  "','CLAVEAQUI'), '" + mail + "')";
			try {
				db.insert(insertQuery);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
			db.desconectarBD();
		}
				
		if (ok) response.sendRedirect("index.jsp");
		else response.sendRedirect("index.jsp");

	}


}
