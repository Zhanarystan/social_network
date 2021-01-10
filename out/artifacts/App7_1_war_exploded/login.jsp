<%--
  Created by IntelliJ IDEA.
  User: mukht
  Date: 09.10.2020
  Time: 00:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Title</title>
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
<div class="wrapper" style="width: 40%; margin-left: auto; margin-right: auto; margin-top: 100px;">
    <div style="title-align: center;">
        <h1>Sign In</h1>
    </div>
    <%
        String passError=request.getParameter("passworderror");
        if(passError!=null){
    %>
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        Incorrect password
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">x</span>
        </button>
    </div>
    <%
        }
    %><%
    String emailError=request.getParameter("emailerror");
    if(emailError!=null){
%>
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        Incorrect email
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">x</span>
        </button>
    </div>
    <%
        }
    %>
    <form action="/auth" method="post">
        <div class="form-group">
            <label for="exampleFormControlInput1">Email address</label>
            <input name="email" type="email" class="form-control" id="exampleFormControlInput1">
        </div>
        <br>
        <div class="form-group">
            <label for="exampleFormControlInput1">Password</label>
            <input name="password" type="password" class="form-control" id="exampleFormControlInput2">
        </div>
        <br>
        <div class="custom-control custom-checkbox">
            <input name="rememberme" type="checkbox" class="custom-control-input" id="customCheck1">
            <label class="custom-control-label" for="customCheck1">Remember Me</label>
        </div>
        <br>
        <button type="submit" class="btn btn-primary" style="background: #112340">Sign Up </button>
    </form>
</div>
</body>
</html>
