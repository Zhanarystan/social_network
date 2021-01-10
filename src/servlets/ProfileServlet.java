package servlets;

import classes.DBManager;
import classes.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(value = "/profile")
public class ProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String email=request.getParameter("email");


        User user=(User)request.getSession().getAttribute("CURRENT_USER");


        String redirect="/profile?oldpassworderror";
        if(request.getParameter("passwordupdatebutton")!=null){

            String oldPassword=request.getParameter("oldpassword");
            String newPassword=request.getParameter("newpassword");
            String newRePassword=request.getParameter("newrepassword");
            if(oldPassword.equals(user.getPassword())){
                redirect="/profile?newrepassworderror";
                if(newPassword.equals(newRePassword)){
                    redirect="/profile?passwordupdatesuccess";
                    user.setPassword(newPassword);
                }
            }
        }
        if(request.getParameter("profileupdatebutton")!=null){
            String fullName=request.getParameter("fullname");
            String birthDate=request.getParameter("birthdate");
            user.setFullName(fullName);
            user.setBirthDate(birthDate);
            redirect="/profile?profileupdatesuccess";
        }
        if(request.getParameter("pictureupdatebutton")!=null){
            System.out.println(request.getParameter("imgurl"));
            String imgURL=request.getParameter("imgurl");
            user.setPictureURL(imgURL);
            redirect="/profile?imageupdatesuccess";
        }



        DBManager.updateUser(user);
        response.sendRedirect(redirect);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/profile.jsp").forward(request,response);
    }
}
