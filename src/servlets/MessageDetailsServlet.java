package servlets;

import classes.Chat;
import classes.DBManager;
import classes.Message;
import classes.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(value = "/chat")
public class MessageDetailsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        User user=(User)request.getSession().getAttribute("CURRENT_USER");
        if(request.getParameter("sended_message")!=null){
            Long sender_id=Long.parseLong(request.getParameter("sender_id"));
            Long chat_id=Long.parseLong(request.getParameter("chat_id"));
            String latest_message=request.getParameter("sended_message");
            Chat chat=DBManager.getChat(chat_id);
            chat.setLatestMessageText(latest_message);
            Long receiver_id=null;
            if(chat.getUser().getId()== user.getId()){
                receiver_id=chat.getOpponentUser().getId();
            }
            else {
                receiver_id=chat.getUser().getId();
            }
            Message message=new Message(chat,DBManager.getUserById(receiver_id),DBManager.getUserById(sender_id),latest_message);
            DBManager.addMessage(message);
            DBManager.updateChat(chat);
            response.sendRedirect("/chat?chatID="+chat.getId());
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id=Long.parseLong(request.getParameter("chatID"));
        ArrayList<Message> messages= DBManager.listMessages(id);
        request.setAttribute("messages",messages);
        request.getRequestDispatcher("/message_details.jsp").forward(request,response);
    }
}
