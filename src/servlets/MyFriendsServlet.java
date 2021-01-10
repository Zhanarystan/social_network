package servlets;

import classes.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(value = "/myfriends")
public class MyFriendsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user=(User)request.getSession().getAttribute("CURRENT_USER");
        if(request.getParameter("requested_user_id")!=null){
            Long id=Long.parseLong(request.getParameter("requested_user_id"));
            if (DBManager.isRequested(user.getId(), id)) {
                DBManager.deleteFriendsRequest(user.getId(), id);
            } else {
                System.out.println("I am here "+id);
                System.out.println(DBManager.addFriendsRequest(new FriendsRequest(id, user.getId())));
            }
            response.sendRedirect("/myfriends?user_full_name="+request.getParameter("user_full_name"));
        }
        if(request.getParameter("confirmation_id")!=null){
            Long id=Long.parseLong(request.getParameter("confirmation_id"));
            if(request.getParameter("confirm")!=null){
                DBManager.addFriend(new Friends(DBManager.getUserById(id),user));
                DBManager.addFriend(new Friends(user,DBManager.getUserById(id)));
                DBManager.deleteFriendsRequest(id, user.getId());
            }
            if(request.getParameter("reject")!=null){
                DBManager.deleteFriendsRequest(id, user.getId());
            }
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
            response.sendRedirect("/myfriends");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user=(User)request.getSession().getAttribute("CURRENT_USER");
        if(request.getParameter("user_full_name")!=null){
            ArrayList<User> friends= DBManager.searchFriends(user.getId(),request.getParameter("user_full_name"));
            request.setAttribute("searched_friends",friends);
            request.setAttribute("result",request.getParameter("user_full_name"));
        }
        else {
            ArrayList<Friends> friends=DBManager.listFriends(user.getId());
            ArrayList<FriendsRequest> friendsRequestArrayList=DBManager.requestsToCurrentUser(user.getId());
            request.setAttribute("friends",friends);
            request.setAttribute("requests_to_current_user",friendsRequestArrayList);
        }
        request.getRequestDispatcher("/myfriends.jsp").forward(request,response);
    }
}
