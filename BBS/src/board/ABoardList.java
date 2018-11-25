package board;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;


@WebServlet("/ABoardList")
public class ABoardList extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ABoardList() {
        super();     
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		System.out.println("Get 호출됨");
		doProcess(request,response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		System.out.println("Post 호출됨");
		doProcess(request,response);
	}
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		BoardDAO boardDAO = new BoardDAO();
		ArrayList<Board> list = boardDAO.getRealTimeData();		
		Gson gson = new Gson();
		
		String jsonData = gson.toJson(list);
		System.out.println(jsonData);
		PrintWriter out = response.getWriter();
		out.println(jsonData);
	}

}
