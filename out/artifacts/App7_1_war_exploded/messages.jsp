<%@ page import="java.time.LocalDate" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="classes.Chat" %>
<%@ page import="classes.Message" %><%--
  Created by IntelliJ IDEA.
  User: mukht
  Date: 16.10.2020
  Time: 02:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Messages</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <style>
        .material-icons{
            font-size: 15px;
        }
    </style>
</head>
<body>
<%@include file="vendor/navbar.jsp"%>
<div class="wrapper" style="width: 80%; margin-left: auto; margin-right: auto; margin-top: 10px;">
    <div class="row">
        <div class="col-md-3">
            <div class="card" style="width: 15rem;">
                <img src="<%=currentUser.getPictureURL()%>" class="card-img-top" alt="...">
                <%

                    LocalDate ld1=LocalDate.now();
                    LocalDate ld3=LocalDate.parse(currentUser.getBirthDate());

                    int age=ld1.getYear()-ld3.getYear();
                    if(ld3.getMonthValue()>ld1.getMonthValue()){
                        age-=1;
                    }
                    else if(ld3.getMonthValue()==ld1.getMonthValue()){
                        if(ld3.getDayOfMonth()>ld1.getDayOfMonth()){
                            age-=1;
                        }
                    }
                %>
            </div>
            <div class="card" style="width: 15rem; font-size: 13px; margin-top: 20px;" >
                <ul class="list-group list-group-flush">
                    <li class="list-group-item"><b><%=currentUser.getFullName()%>, <%=age%> years</b></li>
                    <li class="list-group-item"><a class="nav-link" href="/profile">My Profile</a></li>
                    <li class="list-group-item"><a class="nav-link" href="#">Settings</a></li>
                    <li class="list-group-item"><a class="nav-link" href="/logout" style="color: darkred;">Logout</a></li>
                </ul>
            </div>
        </div>
        <div class="col-md-6">
            <%
                ArrayList<Chat> chats=(ArrayList<Chat>)request.getAttribute("chats");
            %>
            <div class="card" style="margin-bottom: 10px; height: 80px;">
                <div class="card-body">
                    <form action="/messages" method="get">
                        <div class="row">
                            <div class="col-md-9">
                                <div class="form-group">
                                    <input name="messages" type="text" class="form-control" id="exampleFormControlInput1" placeholder="Search Messages">
                                </div>
                            </div>
                            <div class="col-md-3">
                                <button type="submit" class="btn btn-outline-primary" style="width: 100px;"><i class="material-icons" style="color:blue;">search</i> Search</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <%
                if(request.getAttribute("result")!=null){
            %>
            <div class="card" style="margin-bottom: 10px; height: 80px;">
                <div class="card-body">
                    <p>Search results for: <%=String.valueOf(request.getAttribute("result"))%></p>
                </div>
            </div>
            <%
                }
                if(chats!=null){
                    for(Chat chat:chats){
            %>

                <div class="card" style="margin-bottom: 20px; height: 150px;">
                    <div class="card-body">
                        <a href="/chat?chatID=<%=chat.getId()%>">
                        <div class="row">
                            <div class="col-md-3">
                                <%
                                    if(chat.getOpponentUser().getId()==currentUser.getId()){
                                %>
                                <img src="<%=chat.getUser().getPictureURL()%>" alt="Avatar" style="width: 100px; height: 100px;border-radius: 50%;"></a>
                            </div>
                            <div class="col-md-6">
                                <h5><%=chat.getUser().getFullName()%></h5>
                                <%
                                    }
                                    else {
                                %>
                                <img src="<%=chat.getOpponentUser().getPictureURL()%>" alt="Avatar" style="width: 100px; height: 100px;border-radius: 50%;"></a>
                            </div>
                            <div class="col-md-6">
                                <h5><%=chat.getOpponentUser().getFullName()%></h5>
                                <%
                                    }
                                %>

                                <%
                                    int unreadedMessages=0;
                                    ArrayList<Message> messages=DBManager.listMessages(chat.getId());
                                    for(Message message:messages){
                                        if(message.isReadByReceiver()==false && message.getSender().getId()!= currentUser.getId()){
                                            unreadedMessages++;
                                        }
                                    }
                                    if(unreadedMessages!=0){

                                %>
                                <div style="overflow: hidden; height: 80px;">
                                    <p><b><%=chat.getLatestMessageText()%></b></p>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <p style="font-size: 12px;"><%=chat.getLatestMessageTime()%></p>
                                <br>
                                <p>(<%=unreadedMessages%>)</p>
                                <%
                                    }else {
                                %>

                                <div style="overflow: hidden; height: 80px;">
                                    <p><%=chat.getLatestMessageText()%></p>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <p style="font-size: 12px;"><%=chat.getLatestMessageTime()%></p>
                                <%
                                    }
                                %>

                            </div>
                        </div>
                        </a>
                    </div>
                </div>
            <%
                    }
                }
            %>
        </div>
        <div class="col-md-3">
            <div class="card title-white bg-info mb-3" style="max-width: 18rem;">
                <div class="card-header">Latest birthdays</div>
                <div class="card-body" style="background: white; font-size: 13px;">
                    <p class="card-title" style="color: black;">Bekarystan Mukhtarkhan, tomorrow</p>
                    <p class="card-title" style="color: black;">Akbota Nurmanova, 02 October</p>
                    <p class="card-title" style="color: black;">Akzhan Mukhtarkhanova, 25 September</p>
                </div>
            </div>
            <div class="card title-white bg-info mb-3" style="max-width: 18rem; margin-top: 40px;">
                <div class="card-header">My Games</div>
                <div class="card-body" style="background: white; font-size: 13px;">
                    <a class="nav-link" href="#" style="color: #162f72;"><b>FOOTBALL ONLINE</b></a>
                    <a class="nav-link" href="#" style="color: #162f72;"><b>PING PONG ONLINE</b></a>
                    <a class="nav-link" href="#" style="color: #162f72;"><b>CHESS MASTERS</b></a>
                    <a class="nav-link" href="#" style="color: #162f72;"><b>RACES ONLINE</b></a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
