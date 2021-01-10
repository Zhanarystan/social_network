<%@ page import="classes.DBManager" %>
<%@ page import="classes.Chat" %>
<%@ page import="classes.Message" %>
<%@include file="user.jsp"%>
<nav class="navbar" style="background: #162f72;">
    <div class="col-md-1">

    </div>
    <div class="col-md-4">
        <a class="navbar-brand" href="#">
            <i class="material-icons" style="color:white; font-size: 30px; ">spellcheck</i>
            ARALASU.KZ
        </a>
    </div>
    <div class="col-md-7">

        <ul class="nav">
            <%
                if(ONLINE){
            %>
            <li class="nav-item">
                <a class="nav-link active" href="/home" style="color: white;"><i class="material-icons" style="color:white;">insert_comment</i> Feed</a>
            </li>
            <li class="nav-item">
                <%
                    int count= DBManager.countRequests(currentUser.getId());
                %>
                <%
                    if(count==0){
                %>
                <a class="nav-link" href="/myfriends" style="color: white;"><i class="material-icons" style="color:white;">people</i> My Friends</a>
                <%
                    }else {
                %>
                <a class="nav-link" href="/myfriends" style="color: white;"><i class="material-icons" style="color:white;">people</i> My Friends(<%=count%>)</a>
                <%
                    }
                %>

            </li>
            <li class="nav-item">
                <a class="nav-link" href="#" style="color: white;"><i class="material-icons" style="color:white;">groups</i> Groups</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/myposts" style="color: white;"><i class="material-icons" style="color:white;">insert_invitation</i> My Posts</a>
            </li>
            <%
                int newMessageCounter=DBManager.countMessages(currentUser.getId());
                if(newMessageCounter!=0){
            %>
            <li class="nav-item">
                <a class="nav-link" href="/messages" style="color: white;"><i class="material-icons" style="color:white;">send</i> Messages(<%=newMessageCounter%>)</a>
            </li>
            <%
            }else{
            %>
            <li class="nav-item">
                <a class="nav-link" href="/messages" style="color: white;"><i class="material-icons" style="color:white;">send</i> Messages</a>
            </li>
            <%
                }
            %>

            <li class="nav-item">
                <a class="nav-link" href="#" style="color: white;"><i class="material-icons" style="color:white;">insert_photo</i> Pictures</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#" style="color: white;"><i class="material-icons" style="color:white;">videocam</i> Videos</a>
            </li>
            <%
                }
                else {
            %>
            <li class="nav-item">

                <a class="nav-link active" href="/register" style="color: white;"><i class="material-icons" style="color:white;">person_add</i> Register</a>
            </li>
            <li class="nav-item">

                <a class="nav-link" href="/login" style="color: white;"><i class="material-icons" style="color:white;">login</i> Login</a>
            </li>
            <li class="nav-item">

                <a class="nav-link" href="#" style="color: white;"><i class="material-icons" style="color:white;">help_outline</i> FAQ</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#" style="color: white;">About Aralasu</a>
            </li>
            <%
                }
            %>
        </ul>
    </div>
</nav>