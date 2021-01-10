<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="classes.Friends" %>
<%@ page import="java.lang.reflect.Array" %>
<%@ page import="classes.DBManager" %>
<%@ page import="classes.FriendsRequest" %><%--
  Created by IntelliJ IDEA.
  User: mukht
  Date: 09.10.2020
  Time: 10:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Friends</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

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
            <div class="card" style="margin-bottom: 10px; height: 80px;">
                <div class="card-body">
                    <form action="/myfriends" method="get">
                        <div class="row">
                            <div class="col-md-9">
                                <div class="form-group">
                                    <input name="user_full_name" type="text" class="form-control" id="exampleFormControlInput1" placeholder="Search Friends">
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
                ArrayList<Friends> friendsArray=(ArrayList<Friends>)request.getAttribute("friends");
                ArrayList<FriendsRequest> requestsToCurrentUser=(ArrayList<FriendsRequest>)request.getAttribute("requests_to_current_user");
            %>
            <%
                if(requestsToCurrentUser!=null){
            %>
            <div class="card" style="margin-bottom: 20px;">
                <div class="card-body">
            <%
                    for(FriendsRequest friendsRequest: requestsToCurrentUser){
                        User u=DBManager.getUserById(friendsRequest.getRequestSenderId());

                        LocalDate ld10=LocalDate.now();
                        LocalDate ld11=LocalDate.parse(u.getBirthDate());

                        int age3=ld10.getYear()-ld11.getYear();
                        if(ld11.getMonthValue()>ld10.getMonthValue()){
                            age3-=1;
                        }
                        else if(ld11.getMonthValue()==ld10.getMonthValue()){
                            if(ld11.getDayOfMonth()>ld10.getDayOfMonth()){
                                age3-=1;
                            }
                        }

            %>
            <div class="row" style="margin-top: 15px;">
                <div class="col-md-3">
                    <img src="<%=u.getPictureURL()%>" alt="Avatar" style="width: 100px; height: 100px;border-radius: 50%;">
                </div>
                <div class="col-md-9">
                    <h3><%=u.getFullName()%></h3>
                    <p><%=age3%> years</p>
                    <form action="/myfriends" method="post">
                        <input name="confirmation_id" type="hidden" value="<%=u.getId()%>">
                        <button name="confirm" type="submit" class="btn btn-outline-primary" style="width: 100px;"><i class="material-icons" style="color:blue;">add_circle</i> Confirm</button>
                        <button name="reject" type="submit" class="btn btn-outline-primary" style="width: 100px;"><i class="material-icons" style="color:blue;">delete</i> Reject</button>
                    </form>
                </div>
            </div>

            <%
                    }
            %>
                </div>
            </div>
            <%
                }
            %>
            <%
                if(friendsArray!=null){
                    for(Friends friend:friendsArray){

            %>
            <div class="card" style="margin-bottom: 20px;">
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-3">
                            <a href="friend_details?userID=<%=friend.getFriend().getId()%>"><img src="<%=friend.getFriend().getPictureURL()%>" alt="Avatar" style="width: 100px; height: 100px;border-radius: 50%;"></a>
                        </div>
                        <div class="col-md-9">
                            <a href="friend_details?userID=<%=friend.getFriend().getId()%>"><h5><%=friend.getFriend().getFullName()%></h5></a>
                            <%
                                LocalDate ld4=LocalDate.now();
                                LocalDate ld5=LocalDate.parse(friend.getFriend().getBirthDate());

                                int age1=ld4.getYear()-ld5.getYear();
                                if(ld5.getMonthValue()>ld4.getMonthValue()){
                                    age1-=1;
                                }
                                else if(ld5.getMonthValue()==ld4.getMonthValue()){
                                    if(ld5.getDayOfMonth()>ld4.getDayOfMonth()){
                                        age1-=1;
                                    }
                                }
                            %>
                            <p><%=age1%> years old</p>
                            <a class="nav-link" href="#" data-toggle="modal" data-target="#getModal<%=friend.getFriend().getId()%>"><button name="send_message" type="button" class="btn btn-outline-primary" style="width: 150px;"><i class="material-icons" style="color:blue;">send</i> Send Message</button></a>
                            <div class="modal" tabindex="-1" id="getModal<%=friend.getFriend().getId()%>">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">Send Message</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <form action="/myfriends" method="post">
                                                <div class="form-group">
                                                    <label>Send message to <%=friend.getFriend().getFullName()%>:</label>
                                                    <textarea class="form-control" id="exampleFormControlTextarea111" name="message_to_friend" style="height: 200px;"></textarea>
                                                </div>
                                                <div class="modal-footer">
                                                    <input name="userID" type="hidden" value="<%=friend.getFriend().getId()%>">
                                                    <button name="add" type="submit" class="btn btn-primary" style="background: green;">Send</button>
                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal" style="background:red;">Close</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%
                    }
                }
            %>
            <%
                ArrayList<User> searchedFriends=(ArrayList<User>)request.getAttribute("searched_friends");
                if(searchedFriends!=null){
                    for(User user:searchedFriends){
                        if(user.getId()==currentUser.getId()){
                            continue;
                        }

            %>

            <div class="card" style="margin-bottom: 20px;">
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-3">
                            <img src="<%=user.getPictureURL()%>" alt="Avatar" style="width: 100px; height: 100px;border-radius: 50%;">
                        </div>
                        <div class="col-md-9">
                            <h5><%=user.getFullName()%></h5>
                            <%
                                LocalDate ld6=LocalDate.now();
                                LocalDate ld7=LocalDate.parse(user.getBirthDate());

                                int age2=ld6.getYear()-ld7.getYear();
                                if(ld7.getMonthValue()>ld6.getMonthValue()){
                                    age2-=1;
                                }
                                else if(ld7.getMonthValue()==ld6.getMonthValue()){
                                    if(ld7.getDayOfMonth()>ld6.getDayOfMonth()){
                                        age2-=1;
                                    }
                                }
                            %>
                            <p><%=age2%> years old</p>
                            <form method="post">
                                <input name="requested_user_id" type="hidden" value="<%=user.getId()%>">
                                <%
                                    if(DBManager.isRequested(currentUser.getId(), user.getId())==false){
                                %>
                                <button id="request_button<%=user.getId()%>" name="add_to_friends" type="submit" class="btn btn-outline-primary" onclick="buttonFunction<%=user.getId()%>()" style="width: 150px;" value="request_to_friends"><i class="material-icons" style="color:blue;">add_circle</i> Add To Friends</button>
                                <%
                                    }else {
                                %>
                                <button id="request_button<%=user.getId()%>" name="cancel_request_to_friends" type="submit" class="btn btn-outline-primary" onclick="buttonFunction<%=user.getId()%>()" style="width: 150px;" value="cancel_request_to_friends"><i class="material-icons" style="color:blue;">check</i> Request Sent</button>
                                <%
                                    }
                                %>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <script>
                function buttonFunction<%=user.getId()%>() {

                    var btn = document.getElementById("request_button<%=user.getId()%>");

                    if (btn.value == "request_to_friends") {
                        btn.value = "cancel_request_to_friends";
                        btn.innerHTML = "<i class=\"material-icons\" style=\"color:blue;\">check</i> Request Sent";
                    }
                    else {
                        btn.value = "request_to_friends";
                        btn.innerHTML = "<i class=\"material-icons\" style=\"color:blue;\">add_circle</i> Add To Friends";
                    }
                    if(btn.value == "cancel_request_to_friends"){
                        btn.value = "request_to_friends";
                        btn.innerHTML = "<i class=\"material-icons\" style=\"color:blue;\">add_circle</i> Add To Friends"
                    }
                    else {
                        btn.value = "cancel_request_to_friends";
                        btn.innerHTML = "<i class=\"material-icons\" style=\"color:blue;\">check</i> Request Sent";
                    }
                }
            </script>
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
