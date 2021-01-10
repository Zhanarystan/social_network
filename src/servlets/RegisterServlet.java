package servlets;

import classes.DBManager;
import classes.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(value="/register")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String email=request.getParameter("email");
        String redirect="/register?emailerror";
        if(DBManager.getUser(email)==null){
            redirect="/login";
            String password=request.getParameter("password");
            String fullName=request.getParameter("fullname");
            String birthDate=request.getParameter("birthdate");
            User user=new User(email,password,fullName,birthDate);
            DBManager.addUser(user);
        }

        response.sendRedirect(redirect);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request,response);
    }
}
