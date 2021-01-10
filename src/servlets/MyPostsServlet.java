package servlets;

import classes.DBManager;
import classes.Post;
import classes.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(value="/myposts")
public class MyPostsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        if(request.getParameter("add")!=null) {
            String title = request.getParameter("post_title");
            String shortContent = request.getParameter("post_shortcontent");
            String content = request.getParameter("post_content");
            Long id = Long.parseLong(request.getParameter("author_id"));
            DBManager.addPost(new Post(DBManager.getUserById(id), title, shortContent, content));
        }
        if(request.getParameter("save")!=null){
            Long id=Long.parseLong(request.getParameter("post_id"));
            String title = request.getParameter("post_title");
            String shortContent = request.getParameter("post_shortcontent");
            String content = request.getParameter("post_content");
            Post post=DBManager.getPost(id);
            post.setTitle(title);
            post.setShortContent(shortContent);
            post.setContent(content);
            DBManager.updatePost(post);
        }
        if(request.getParameter("delete")!=null){
            Long id=Long.parseLong(request.getParameter("post_id"));
            DBManager.deletePost(id);
        }
        response.sendRedirect("/myposts");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ArrayList<Post> posts = DBManager.listPosts(((User)request.getSession().getAttribute("CURRENT_USER")).getId());
        request.setAttribute("posts", posts);
        request.getRequestDispatcher("/myposts.jsp").forward(request,response);
    }
}
