package pk;

import java.io.IOException;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/FeedSub")
public class FeedSub extends HttpServlet {
	private static final long serialVersionUID = 3L;

	public FeedSub() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.sendRedirect("./index.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		beanDB db = new beanDB();
		boolean okdb = false;
		boolean ok=false;

		try {
			db.conectarBD();
			okdb = true;
		} catch (Exception e) {
			okdb = false;
			e.printStackTrace();
		}

		if (okdb) {
			String subject = request.getParameter("subject");
			String message = request.getParameter("text");
			String query = "INSERT INTO FEEDBACK (SUBJECTS, MESSAGES) VALUES ('" + subject + "','" + message + "')";
			try {
				db.insert(query);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			ok=true;
		}
		db.desconectarBD();
		
		if (ok) response.sendRedirect("index.jsp");
		else response.sendRedirect("index.jsp");
	}

}
