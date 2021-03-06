<%@ page import="java.time.LocalDate" %>
<%@ page import="classes.Post" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.time.LocalDateTime" %><%--
  Created by IntelliJ IDEA.
  User: mukht
  Date: 09.10.2020
  Time: 08:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>My posts</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    <script src="https://cdn.tiny.cloud/1/8jvn6se43ufwnqfkdh3y4cv9bjbmpk9hanjfzuu76nff7kcx/tinymce/5/tinymce.min.js" referrerpolicy="origin"></script>
    <script>tinymce.init({selector:'textarea'});</script>
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
                <%
                    if(currentUser.getPictureURL()==null){
                %>
                <img src="https://static1.bigstockphoto.com/6/5/1/large1500/15601130.jpg" class="card-img-top" alt="...">
                <%  }
                else {

                %>
                <img src="<%=currentUser.getPictureURL()%>" class="card-img-top" alt="...">
                <%
                    }
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
            <% ArrayList<Post> posts=(ArrayList<Post>)request.getAttribute("posts");  %>
            <a href="#" data-toggle="modal" data-target="#getModal"><button type="button" class="btn btn-primary btn-sm" style="background: #162f72; margin-bottom: 10px;"><i class="material-icons" style="color:white; font-size: 20px; ">add_box</i> Add New</button></a>
            <%
                if(posts!=null){
                    for(Post post:posts){
            %>
            <div class="card" style="margin-bottom: 20px;">
                <div class="card-body">
                    <h5 class="card-title"><%=post.getTitle()%></h5>
                    <p class="card-title"><%=post.getShortContent()%></p>
                    <button type="button" class="btn btn-outline-primary" style="width: 80px;">More</button>
                    <div class="content" style="padding: 0 18px; display: none; overflow: hidden;">
                        <div class="card-body">
                            <%=post.getContent()%>
                            <br>

                            <form action="/myposts" method="post">
                                <a href="#" name="post_id" data-toggle="modal" data-target="#getModal<%=post.getId()%>"><button type="button" class="btn btn-primary btn-sm">EDIT</button></a>
                                <input type="hidden" name="post_id" value="<%=post.getId()%>">
                                <button name="delete" type="submit" class="btn btn-secondary btn-sm" style="background: red;">DELETE</button>
                            </form>
                            <div class="modal" tabindex="-1" id="getModal<%=post.getId()%>">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">Edit Post</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <form action="/myposts" method="post">
                                                <div class="form-group">
                                                    <label for="exampleFormControlInput1">TITLE:</label>
                                                    <input type="text" class="form-control" id="exampleFormControlInput10" name="post_title" value="<%=post.getTitle()%>">
                                                </div>
                                                <div class="form-group">
                                                    <label for="exampleFormControlInput1">SHORT CONTENT:</label>
                                                    <textarea class="form-control" id="exampleFormControlTextarea1311" name="post_shortcontent" style="height: 200px;"><%=post.getShortContent()%></textarea>
                                                </div>
                                                <div class="form-group">
                                                    <label for="exampleFormControlInput1">CONTENT:</label>
                                                    <textarea class="form-control" id="exampleFormControlTextarea1112" name="post_content" style="height: 200px;"><%=post.getContent()%></textarea>
                                                </div>
                                                <div class="modal-footer">
                                                    <input type="hidden" name="post_id" value="<%=post.getId()%>">
                                                    <button name="save" type="submit" class="btn btn-primary" style="background: darkblue;">SAVE</button>
                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal" style="background:grey;">CANCEL</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="card-footer">
                    <%
                        String time=String.valueOf(post.getPostDate());
                        LocalDateTime ld=LocalDateTime.parse(time.replace(" ","T"));
                    %>
                    <small class="title-muted">Posted on <%=ld.getMonth()%> <%=ld.getDayOfMonth()%>,
                        <%=ld.getYear()%> by <%=post.getAuthor().getFullName()%></small>
                </div>
            </div>
            <%
                    }
                }
            %>
            <script>
                var coll = document.getElementsByClassName("btn btn-outline-primary");
                var i;

                for (i = 0; i < coll.length; i++) {
                    coll[i].addEventListener("click", function() {
                        this.classList.toggle("active");
                        var content = this.nextElementSibling;
                        if (content.style.display === "block") {
                            content.style.display = "none";
                        } else {
                            content.style.display = "block";
                        }
                    });
                }
            </script>
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
<div class="modal" tabindex="-1" id="getModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Add New Post</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="/myposts" method="post">
                    <div class="form-group">
                        <label for="exampleFormControlInput1">TITLE:</label>
                        <input type="text" class="form-control" id="exampleFormControlInput1" name="post_title">
                    </div>
                    <div class="form-group">
                        <label for="exampleFormControlInput1">SHORT CONTENT:</label>
                        <textarea class="form-control" id="exampleFormControlTextarea11" name="post_shortcontent" style="height: 200px;"></textarea>
                    </div>
                    <div class="form-group">
                        <label for="exampleFormControlInput1">CONTENT:</label>
                        <textarea class="form-control" id="exampleFormControlTextarea111" name="post_content" style="height: 200px;"></textarea>
                    </div>
                    <input type="hidden" name="author_id" value="<%=currentUser.getId()%>">
                    <div class="modal-footer">
                        <button name="add" type="submit" class="btn btn-primary" style="background: darkblue;">ADD</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal" style="background:grey;">CANCEL</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
