package servlets;

import classes.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(value = "/friend_details")
public class FriendDetailsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        User user= (User) request.getSession().getAttribute("CURRENT_USER");
        if(request.getParameter("friend_remove_id")!=null){
            DBManager.deleteFriend(user.getId(), Long.parseLong(request.getParameter("friend_remove_id")));
            DBManager.deleteFriend(Long.parseLong(request.getParameter("friend_remove_id")),user.getId());
            response.sendRedirect("/myfriends");
        }

        if(request.getParameter("message_to_friend")!=null){
            User user1=DBManager.getUserById(Long.parseLong(request.getParameter("userID")));
            String messageText=request.getParameter("message_to_friend");
            if(DBManager.isChatExists(user.getId(),user1.getId())==true || DBManager.isChatExists(user1.getId(),user.getId())==true){
                Message message=new Message(DBManager.getChat(user.getId(),user1.getId()),user1,user,messageText);
                DBManager.addMessage(message);
                Chat chat1=DBManager.getChat(user.getId(),user1.getId());
                chat1.setLatestMessageText(messageText);
                DBManager.updateChat(chat1);
            }
            else {
                DBManager.addChat(new Chat(user,user1,messageText));
                Message message=new Message(DBManager.getChat(user.getId(),user1.getId()),user1,user,messageText);
                DBManager.addMessage(message);
            }
            response.sendRedirect("/friend_details?userID="+user1.getId());
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(request.getParameter("userID")!=null){
            User user= DBManager.getUserById(Long.parseLong(request.getParameter("userID")));
            ArrayList<Post> posts=DBManager.listPosts(user.getId());
            request.setAttribute("friend",user);
            request.setAttribute("posts",posts);
        }
        request.getRequestDispatcher("/friend_details.jsp").forward(request,response);
    }
}
