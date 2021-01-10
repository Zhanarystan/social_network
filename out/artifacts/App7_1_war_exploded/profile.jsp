<%@ page import="java.time.LocalDate" %>
<!DOCTYPE html>
<html>
<head>
    <title>Index</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    <script src="https://cdn.tiny.cloud/1/8jvn6se43ufwnqfkdh3y4cv9bjbmpk9hanjfzuu76nff7kcx/tinymce/5/tinymce.min.js" referrerpolicy="origin"></script>
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
        <div class="col-md-5">
            <h3>Edit Profile</h3>
            <form action="/profile" method="post">
                <div class="form-group">
                    <label for="exampleFormControlInput1">Email address</label>
                    <input name="email" type="email" class="form-control" id="exampleFormControlInput1" value="<%=currentUser.getEmail()%>" readonly>
                </div>
                <div class="form-group">
                    <label for="exampleFormControlInput1">Full Name</label>
                    <input name="fullname" type="title" class="form-control" id="exampleFormControlInput5" value="<%=currentUser.getFullName()%>">
                </div>
                <div class="form-group">
                    <label>Birthdate</label>
                    <input type="date" class="form-control" id="date" name="birthdate" placeholder="mm/dd/yyyy" value="<%=currentUser.getBirthDate()%>">
                </div>
                <button name="profileupdatebutton" type="submit" class="btn btn-primary" style="background: #112340">Update Profile </button>
            </form>
            <%
                if(request.getParameter("profileupdatesuccess")!=null){
            %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                Profile successfully updated
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">x</span>
                </button>
            </div>
            <%
                }
              %>
            <hr>

            <h3>Edit Picture</h3>
            <form action="/profile" method="post">
                <div class="form-group">
                    <label for="exampleFormControlInput1">URL</label>
                    <input name="imgurl" type="title" class="form-control" id="exampleFormControlInput6" value="<%=currentUser.getPictureURL()%>">
                </div>
                <button name="pictureupdatebutton" type="submit" class="btn btn-primary" style="background: #112340">Update URL </button>
            </form>
            <%
                if(request.getParameter("imageupdatesuccess")!=null){
            %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                Picture successfully updated
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">x</span>
                </button>
            </div>
            <%
                }
            %>
            <hr>

            <h3>Update Password</h3>
            <form action="/profile" method="post">

                <div class="form-group">
                    <label for="exampleFormControlInput1">Old Password</label>
                    <input name="oldpassword" type="password" class="form-control" id="exampleFormControlInput7">
                </div>
                <div class="form-group">
                    <label for="exampleFormControlInput1">New Password</label>
                    <input name="newpassword" type="password" class="form-control" id="exampleFormControlInput8">
                </div>
                <br>
                <div class="form-group">
                    <label for="exampleFormControlInput1">Re-New Password</label>
                    <input name="newrepassword" type="password" class="form-control" id="exampleFormControlInput4">
                </div>
                <button name="passwordupdatebutton" type="submit" class="btn btn-primary" style="background: #112340">Update Password</button>
            </form>
            <%
                String passError=request.getParameter("oldpassworderror");
                if(passError!=null){
            %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                Incorrect old password
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">x</span>
                </button>
            </div>
            <%
                }
            %>
            <%
                String repassError=request.getParameter("newrepassworderror");
                if(repassError!=null){
            %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                Incorrect re-password
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">x</span>
                </button>
            </div>
            <%
                }
            %>
            <%
                if(request.getParameter("passwordupdatesuccess")!=null){
            %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                Successfully updated
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">x</span>
                </button>
            </div>
            <%
                }
            %>
        </div>
        <div class="col-md-1">

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
