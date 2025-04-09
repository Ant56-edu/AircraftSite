package pk;

import java.io.IOException;
import java.sql.SQLException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/EntryUpload")
public class EntryUpload extends HttpServlet {
	private static final long serialVersionUID = 5L;

	public EntryUpload() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.sendRedirect("index.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		beanDB db = new beanDB();
		boolean okdb = false;
		boolean ok = false;

		try {
			db.conectarBD();
			okdb = true;
		} catch (Exception e) {
			okdb = false;
			e.printStackTrace();
		}

		if (okdb) {
			String entryType = request.getParameter("entryType");
			String name = request.getParameter("name");
			String type = request.getParameter("type");
			String country = request.getParameter("country");
			String desc = request.getParameter("desc");
			String manufacturerString = request.getParameter("manufacturer");
			String wiki = request.getParameter("wiki");
			String[][] tablaManu = null;
			String[][] tablaTipo = null;
			try {
				tablaManu = db
						.resConsultaSelectA3("SELECT manId FROM MANUFACTURER WHERE name='" + manufacturerString + "';");
				tablaTipo = db.resConsultaSelectA3("select planeTypeId from PLANETYPES where type = '" + type + "';");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			int manufacturer = 0;
			int typeId = 0;
			if (tablaManu != null) {
				for (int i = 0; i < tablaManu.length; i++) {
					manufacturer = Integer.parseInt(tablaManu[i][0]);
				}
			}

			if (tablaTipo != null) {
				for (int i = 0; i < tablaManu.length; i++) {
					typeId = Integer.parseInt(tablaManu[i][0]);
				}
			}

			if (entryType.equals("planeEntry")) {
				String query = "INSERT INTO MODEL (name, countryId, `shortDesc`, manId, planeTypeId, wikiLink) VALUES ('"
						+ name + "','" + country + "','" + desc + "','" + manufacturer + "','" + typeId
						+ "','<a href=\"" + wiki + "\">Wikipedia Link</a>');";
				try {
					db.insert(query);
					query = "INSERT INTO MAN_HAS_MODEL (modId, manId) VALUES ((SELECT max(modId) FROM MODEL),"
							+ manufacturer + ");";
					db.insert(query);
					ok = true;
				} catch (SQLException e) {
					e.printStackTrace();
				}
			} else if (entryType.equals("manufacturerEntry")) {
				String query = "INSERT INTO MANUFACTURER (name, countryId, `shortDesc`, wikiLink) VALUES ('" + name
						+ "','" + country + "','" + desc + "','<a href=\"" + wiki + "\">Wikipedia Link</a>');";
				try {
					db.insert(query);
					ok = true;
				} catch (SQLException e) {
					e.printStackTrace();
				}
			} else if (entryType.equals("weaponEntry")) {
				String query = "INSERT INTO ARMAMENTS (name, `desc`, wikiLink) VALUES ('" + name + "','" + desc
						+ "','<a href=\"" + wiki + "\">Wikipedia Link</a>');";
				try {
					db.insert(query);
					query = "INSERT INTO ARMS_HAS_ARMTYPE (armId, armTypeId) VALUES ((SELECT max(armId) FROM ARMAMENTS),"
							+ typeId + ");";
					db.insert(query);
					query = "INSERT INTO MAN_HAS_ARMS (armId, manId) VALUES ((SELECT max(armId) FROM ARMAMENTS),"
							+ manufacturer + ");";
					db.insert(query);
					ok = true;
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		db.desconectarBD();

		if (ok)
			response.sendRedirect("editor.jsp");
		else
			response.sendRedirect("editor.jsp");
	}

}
