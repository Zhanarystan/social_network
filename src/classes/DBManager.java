package classes;

import java.sql.*;
import java.util.ArrayList;

public class DBManager {
    private static Connection connection;

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection= DriverManager.getConnection("jdbc:mysql://localhost:3306/social?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC","root","");

        }catch (Exception e){
            e.printStackTrace();
        }
    }

    public static boolean addUser(User user){
        int rows=0;

        try{
            PreparedStatement statement=connection.prepareStatement("INSERT INTO users(id, email, password, full_name, " +
                    "birth_date, picture_url) VALUES (NULL, ?, ?, ?, ?, ?)");
            statement.setString(1,user.getEmail());
            statement.setString(2, user.getPassword());
            statement.setString(3,user.getFullName());
            statement.setString(4,user.getBirthDate());
            statement.setString(5,"https://static1.bigstockphoto.com/6/5/1/large1500/15601130.jpg");

            rows=statement.executeUpdate();
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return rows>0;
    }

    public static boolean addPost(Post post){
        int rows=0;

        try{
            PreparedStatement statement=connection.prepareStatement("INSERT INTO posts(id, author_id, title, short_content, " +
                    "content, post_date) VALUES (NULL, ?, ?, ?, ?, ?)");
            statement.setLong(1,post.getAuthor().getId());
            statement.setString(2,post.getTitle());
            statement.setString(3,post.getShortContent());
            statement.setString(4,post.getContent());
            statement.setTimestamp(5,new Timestamp(System.currentTimeMillis()));

            rows=statement.executeUpdate();
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }

        return rows>0;
    }

    public static boolean addFriend(Friends friends){
        int rows=0;

        try{
            PreparedStatement statement=connection.prepareStatement("INSERT INTO friends(id, user_id, friend_id, added_time) VALUES (NULL, ?, ?, ?)");
            statement.setLong(1,friends.getUser().getId());
            statement.setLong(2,friends.getFriend().getId());
            statement.setTimestamp(3,new Timestamp(System.currentTimeMillis()));
            rows=statement.executeUpdate();
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }

        return rows>0;
    }


    public static boolean addFriendsRequest(FriendsRequest friendsRequest){
        int rows=0;

        try{
            PreparedStatement statement=connection.prepareStatement("INSERT INTO friends_requests(id, user_id, request_sender_id, sent_time) VALUES (NULL, ?, ?, ?)");
            statement.setLong(1,friendsRequest.getUserId());
            statement.setLong(2,friendsRequest.getRequestSenderId());
            statement.setTimestamp(3,new Timestamp(System.currentTimeMillis()));
            rows=statement.executeUpdate();
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }

        return rows>0;
    }

    public static User getUser(String email){
        User user=null;

        try {
            PreparedStatement statement=connection.prepareStatement("SELECT * FROM users WHERE email = ?");
            statement.setString(1,email);
            ResultSet resultSet=statement.executeQuery();
            while (resultSet.next()){
                user=new User(resultSet.getLong("id"),
                        resultSet.getString("email"),
                        resultSet.getString("password"),
                        resultSet.getString("full_name"),
                        resultSet.getString("birth_date"),
                        resultSet.getString("picture_url"));
            }
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }

        return user;
    }

    public static User getUserById(Long id){
        User user=null;

        try {
            PreparedStatement statement=connection.prepareStatement("SELECT * FROM users WHERE id = ?");
            statement.setLong(1,id);
            ResultSet resultSet=statement.executeQuery();
            while (resultSet.next()){
                user=new User(resultSet.getLong("id"),
                        resultSet.getString("email"),
                        resultSet.getString("password"),
                        resultSet.getString("full_name"),
                        resultSet.getString("birth_date"),
                        resultSet.getString("picture_url"));
            }
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }

        return user;
    }

    public static Post getPost(Long id){
        Post post=null;
        try{
            PreparedStatement statement=connection.prepareStatement("SELECT * FROM posts WHERE id = ?");
            statement.setLong(1,id);
            ResultSet resultSet=statement.executeQuery();
            while (resultSet.next()){
                post=new Post(resultSet.getLong("id"),
                        DBManager.getUserById(resultSet.getLong("author_id")),
                        resultSet.getString("title"),
                        resultSet.getString("short_content"),
                        resultSet.getString("content"),
                        resultSet.getTimestamp("post_date"));
            }
            statement.close();
        } catch (Exception e){
            e.printStackTrace();
        }

        return post;
    }

    public static ArrayList<Post> allPosts(){
        ArrayList<Post> posts=new ArrayList<>();

        try{
            PreparedStatement statement=connection.prepareStatement("SELECT * FROM posts");
            ResultSet resultSet=statement.executeQuery();
            while (resultSet.next()){
                posts.add(new Post(resultSet.getLong("id"),
                        DBManager.getUserById(resultSet.getLong("author_id")),
                        resultSet.getString("title"),
                        resultSet.getString("short_content"),
                        resultSet.getString("content"),
                        resultSet.getTimestamp("post_date")));
            }
            statement.close();
        } catch (Exception e){
            e.printStackTrace();
        }

        return posts;
    }

    public static ArrayList<Post> listPosts(Long id){
        ArrayList<Post> posts=new ArrayList<>();

        try{
            PreparedStatement statement=connection.prepareStatement("SELECT * FROM posts WHERE author_id = ?");
            statement.setLong(1,id);
            ResultSet resultSet=statement.executeQuery();
            while (resultSet.next()){
                posts.add(new Post(resultSet.getLong("id"),
                        DBManager.getUserById(resultSet.getLong("author_id")),
                        resultSet.getString("title"),
                        resultSet.getString("short_content"),
                        resultSet.getString("content"),
                        resultSet.getTimestamp("post_date")));
            }
            statement.close();
        } catch (Exception e){
            e.printStackTrace();
        }

        return posts;
    }

    public static ArrayList<Friends> listFriends(Long id){
        ArrayList<Friends> friends=new ArrayList<>();

        try{
            PreparedStatement statement=connection.prepareStatement("SELECT * FROM friends WHERE user_id = ?");
            statement.setLong(1,id);
            ResultSet resultSet=statement.executeQuery();
            while (resultSet.next()){
                friends.add(new Friends(resultSet.getLong("id"),DBManager.getUserById(resultSet.getLong("user_id")),
                        DBManager.getUserById(resultSet.getLong("friend_id")),resultSet.getTimestamp("added_time")));
            }
            statement.close();
        } catch (Exception e){
            e.printStackTrace();
        }

        return friends;
    }

    public static ArrayList<User> searchFriends(Long id, String substring){
        ArrayList<User> users=new ArrayList<>();
        try{
            PreparedStatement statement=connection.prepareStatement("SELECT * FROM users WHERE full_name LIKE ? AND id NOT IN (SELECT friend_id FROM friends WHERE user_id = ?)");
            statement.setString(1,"%"+substring+"%");
            statement.setLong(2,id);
            ResultSet resultSet=statement.executeQuery();
            while (resultSet.next()){
                users.add(new User(resultSet.getLong("users.id"),resultSet.getString("users.email"),
                        resultSet.getString("users.password"),resultSet.getString("users.full_name"),
                        resultSet.getString("users.birth_date"),
                        resultSet.getString("users.picture_url")));
            }
            statement.close();

        }catch (Exception e){
            e.printStackTrace();
        }

        return users;
    }


    public static boolean updateUser(User user){
        int rows=0;
        try {
            PreparedStatement statement=connection.prepareStatement("UPDATE users SET email = ?, password = ?, " +
                    "full_name = ?, birth_date = ?, picture_url = ? WHERE id = ?");
            statement.setString(1,user.getEmail());
            statement.setString(2,user.getPassword());
            statement.setString(3,user.getFullName());
            statement.setString(4,user.getBirthDate());
            statement.setString(5, user.getPictureURL());
            statement.setLong(6, user.getId());
            rows=statement.executeUpdate();
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return rows>0;
    }

    public static boolean updatePost(Post post){
        int rows=0;
        try {
            PreparedStatement statement=connection.prepareStatement("UPDATE posts SET title = ?, short_content = ?, " +
                    "content = ? WHERE id = ?");
            statement.setString(1,post.getTitle());
            statement.setString(2,post.getShortContent());
            statement.setString(3,post.getContent());
            statement.setLong(4,post.getId());
            rows=statement.executeUpdate();
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return rows>0;
    }

    public static boolean deletePost(Long id){
        int rows=0;
        try{
            PreparedStatement statement=connection.prepareStatement("DELETE FROM posts WHERE id = ?");
            statement.setLong(1,id);
            rows=statement.executeUpdate();
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return rows>0;
    }

    public static boolean deleteFriend(Long id, Long id1){
        int rows=0;

        try {
            PreparedStatement statement=connection.prepareStatement("DELETE FROM friends WHERE user_id = ? AND friend_id = ?");
            statement.setLong(1,id);
            statement.setLong(2,id1);
            rows=statement.executeUpdate();
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }

        return rows>0;
    }

    public static boolean deleteFriendsRequest(Long senderId, Long userId){
        int rows=0;
        try{
            PreparedStatement statement=connection.prepareStatement("DELETE FROM friends_requests WHERE user_id = ? AND request_sender_id = ?");
            statement.setLong(1,userId);
            statement.setLong(2,senderId);
            rows=statement.executeUpdate();
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return rows>0;
    }

    public static boolean isRequested(Long senderId, Long userId){
        boolean isRequested=true;
        FriendsRequest fr=null;
        try {
            PreparedStatement statement=connection.prepareStatement("SELECT * FROM friends_requests WHERE user_id = ? AND request_sender_id = ?");
            statement.setLong(1,userId);
            statement.setLong(2,senderId);
            ResultSet resultSet=statement.executeQuery();
            while (resultSet.next()){
                fr=new FriendsRequest(resultSet.getLong("id"),resultSet.getLong("user_id"),
                        resultSet.getLong("request_sender_id"),resultSet.getTimestamp("sent_time"));
            }
            

            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }

        if(fr==null){
            isRequested=false;
        }
        return isRequested;
    }

    public static ArrayList<FriendsRequest> requestsToCurrentUser(Long id){
        ArrayList<FriendsRequest> requests=new ArrayList<>();

        try{
            PreparedStatement statement=connection.prepareStatement("SELECT * FROM friends_requests WHERE user_id = ?");
            statement.setLong(1,id);
            ResultSet resultSet=statement.executeQuery();
            while (resultSet.next()){
                requests.add(new FriendsRequest(resultSet.getLong("id"),
                        resultSet.getLong("user_id"),
                        resultSet.getLong("request_sender_id"),
                        resultSet.getTimestamp("sent_time")));
            }
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }

        return requests;
    }

    public static int countRequests(Long id){
        int count=0;

        try {
            PreparedStatement statement=connection.prepareStatement("SELECT * FROM friends_requests WHERE user_id = ?");
            statement.setLong(1,id);
            ResultSet resultSet=statement.executeQuery();
            while (resultSet.next()){
                count++;
            }
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }

        return count;
    }

    public static boolean addChat(Chat chat){
        int rows=0;

        try{
            PreparedStatement statement=connection.prepareStatement("INSERT INTO chats(id, user_id, opponent_user_id," +
                    "created_date, latest_message_text, latest_message_time) VALUES (NULL, ?, ?, NULL, ?, NULL)");
            statement.setLong(1,chat.getUser().getId());
            statement.setLong(2,chat.getOpponentUser().getId());
            statement.setString(3,chat.getLatestMessageText());
            rows=statement.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }

        return rows>0;
    }

    public static ArrayList<Chat> listChats(Long id){
        ArrayList<Chat> chats=new ArrayList<>();

        try {
            PreparedStatement statement=connection.prepareStatement("SELECT * FROM chats WHERE user_id = ? OR opponent_user_id = ?");
            statement.setLong(1,id);
            statement.setLong(2,id);
            ResultSet resultSet=statement.executeQuery();
            while (resultSet.next()){
                chats.add(new Chat(resultSet.getLong("id"),
                        DBManager.getUserById(resultSet.getLong("user_id")),
                        DBManager.getUserById(resultSet.getLong("opponent_user_id")),
                        resultSet.getTimestamp("created_date"),
                        resultSet.getString("latest_message_text"),
                        resultSet.getTimestamp("latest_message_time")));
            }
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }

        return chats;
    }

    public static Chat getChat(Long id){
        Chat chat=null;
        try {
            PreparedStatement statement=connection.prepareStatement("SELECT * FROM chats WHERE id = ?");
            statement.setLong(1,id);
            ResultSet resultSet=statement.executeQuery();
            while (resultSet.next()){
                chat=new Chat(resultSet.getLong("id"),DBManager.getUserById(resultSet.getLong("user_id")),
                        DBManager.getUserById(resultSet.getLong("opponent_user_id")),resultSet.getTimestamp("created_date"),
                        resultSet.getString("latest_message_text"), resultSet.getTimestamp("latest_message_time"));
            }

            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return chat;
    }

    public static Chat getChat(Long user,Long user1){
        Chat chat=null;
        try {
            PreparedStatement statement=connection.prepareStatement("SELECT * FROM chats WHERE (user_id = ? AND opponent_user_id = ?) OR (opponent_user_id = ? AND user_id = ?)");
            statement.setLong(1,user);
            statement.setLong(2,user1);
            statement.setLong(3,user);
            statement.setLong(4,user1);
            ResultSet resultSet=statement.executeQuery();
            while (resultSet.next()){
                chat=new Chat(resultSet.getLong("id"),DBManager.getUserById(resultSet.getLong("user_id")),
                        DBManager.getUserById(resultSet.getLong("opponent_user_id")),resultSet.getTimestamp("created_date"),
                        resultSet.getString("latest_message_text"), resultSet.getTimestamp("latest_message_time"));
            }

            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return chat;
    }

    public static boolean updateChat(Chat chat){
        int rows=0;

        try {
            PreparedStatement statement=connection.prepareStatement("UPDATE chats SET latest_message_text = ?, " +
                    "latest_message_time = ? WHERE user_id = ? AND opponent_user_id = ?");
            statement.setString(1,chat.getLatestMessageText());
            statement.setTimestamp(2,new Timestamp(System.currentTimeMillis()));
            statement.setLong(3,chat.getUser().getId());
            statement.setLong(4,chat.getOpponentUser().getId());
            rows=statement.executeUpdate();
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }

        return rows>0;
    }

    public static boolean isChatExists(Long userId, Long opponentId){
        boolean isChatExists=true;
        Chat chat=null;
        try {
            PreparedStatement statement=connection.prepareStatement("SELECT * FROM chats WHERE user_id = ? AND opponent_user_id = ?");
            statement.setLong(1,userId);
            statement.setLong(2,opponentId);
            ResultSet resultSet=statement.executeQuery();
            while (resultSet.next()){
                chat=new Chat(resultSet.getLong("id"),DBManager.getUserById(resultSet.getLong("user_id")),
                        DBManager.getUserById(resultSet.getLong("opponent_user_id")),resultSet.getTimestamp("created_date"),
                        resultSet.getString("latest_message_text"), resultSet.getTimestamp("latest_message_time"));
            }


            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }

        if(chat==null){
            isChatExists=false;
        }
        return isChatExists;
    }

    public static boolean addMessage(Message message){
        int rows=0;

        try {
            PreparedStatement statement=connection.prepareStatement("INSERT INTO messages(id, chat_id, user_id, sender_id," +
                    "message_text, read_by_receiver, sent_date) VALUES (NULL, ?, ?, ?, ?, ?, NULL )");
            statement.setLong(1,message.getChat().getId());
            statement.setLong(2,message.getUser().getId());
            statement.setLong(3,message.getSender().getId());
            statement.setString(4,message.getMessageText());
            statement.setBoolean(5,false);
            rows=statement.executeUpdate();
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }

        return rows>0;
    }

    public static ArrayList<Message> listMessages(Long chatID){
        ArrayList<Message> messages=new ArrayList<>();

        try {
            PreparedStatement statement=connection.prepareStatement("SELECT * FROM messages WHERE chat_id = ?");
            statement.setLong(1,chatID);
            ResultSet resultSet=statement.executeQuery();
            while (resultSet.next()){
                messages.add(new Message(resultSet.getLong("id"),
                        DBManager.getChat(resultSet.getLong("chat_id")),
                        DBManager.getUserById(resultSet.getLong("user_id")),
                        DBManager.getUserById(resultSet.getLong("sender_id")),
                        resultSet.getString("message_text"),
                        resultSet.getBoolean("read_by_receiver"),
                        resultSet.getTimestamp("sent_date")));
            }
        }catch (Exception e){
            e.printStackTrace();
        }

        return messages;
    }

    public static boolean updateMessage(Message message){
        int rows=0;

        try {
            PreparedStatement statement=connection.prepareStatement("UPDATE messages SET read_by_receiver = ? WHERE id = ?");
            statement.setBoolean(1,message.isReadByReceiver());
            statement.setLong(2,message.getId());
            rows=statement.executeUpdate();
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }

        return rows>0;
    }

    public static int countMessages(Long id){
        int count=0;

        ArrayList<Chat> chats=DBManager.listChats(id);
        for(int i=0;i<chats.size();i++){
            ArrayList<Message> messages=DBManager.listMessages(chats.get(i).getId());
            for(int j=0;j<messages.size();j++){
                if(messages.get(j).isReadByReceiver()==false && messages.get(j).getSender().getId()!= id){
                    count++;
                    break;
                }
            }
        }

        return count;
    }
}

