function startServer(region,ins_id,name,tag){
    sendPostRequestAWSHandler("Start",region,ins_id,tag);
}

function stopServer(region,ins_id,name,tag){
    sendPostRequestAWSHandler("Stop",region,ins_id,tag);
}

function updateServerStatus(region,ins_id,name,tag){
    sendGetRequestAWSHandler("Update",region,ins_id,tag.id);
}

function sendPostRequestAWSHandler(type, region, ins_id, tag){
    $.ajax({
        url:'AWSHandler',
        data:{"type":type,"region":region,"ins_id":ins_id},
        type:'POST',
        dataType: "json",
        complete:function(){
            var button=document.getElementById(tag.id);
            button.style.display='none' ;
            var str=tag.id.split("_");
            sendGetRequestAWSHandler("Update",region,ins_id,str[1])
        }
    });
}

function sendGetRequestAWSHandler(type,region,ins_id,id){
    $.ajax({
        url: 'AWSHandler',
        data:{"type":type,"region":region,"ins_id":ins_id},
        type: 'GET',
        dataType:'text',
        success:function(response) {
            updateStatusOnTable(type,region,ins_id,id,response);
        }
    });
}

function updateStatusOnTable(type,region,ins_id,id,response) {
    var status=document.getElementById("Status_"+id);
    var start=document.getElementById("Start_"+id);
    var stop=document.getElementById("Stop_"+id);

    status.innerHTML = response;

    if(response=="running"){
        start.style.display = 'none';
        stop.style.display = 'block'
    }
    else if(response=="stopped"){
        start.style.display = 'block';
        stop.style.display = 'none';
    }
    else {
        start.style.display = 'none';
        stop.style.display = 'none';
        setTimeout(sendGetRequestAWSHandler(type,region,ins_id,id),1000);
    }
}

function addServer(){
    var region=document.getElementById("region");
    var name=document.getElementById("Name");
    var ins_id=document.getElementById("InstanceID");

    $.ajax({
        url:'AddServer',
        data:{"region":region.value,"ins_id":ins_id.value,"name":name.value},
        type:'POST',
        dataType: "json",
        complete:function(){
            name.value="";
            ins_id.value="";
            $( "#ServerList" ).load( window.location.href+" #ServerList" );
        }
    });
}

function removeServer(ins_id){
    $.ajax({
        url:'RemoveServer',
        data:{"ins_id":ins_id},
        type:'POST',
        dataType: "json",
        complete:function(){
            $( "#ServerList" ).load( window.location.href+" #ServerList" );
        }
    });
}

function addUser(){
    var userName=document.getElementById("userName");
    var password=document.getElementById("password");
    var userType=document.getElementById("userType");

    $.ajax({
        url:'AddUser',
        data:{"userName":userName.value,"password":password.value,"userType":userType.value},
        type:'POST',
        dataType: "json",
        complete:function(){
            userName.value="";
            password.value="";
            $( "#UserList" ).load( window.location.href+" #UserList" );
        }
    });
}

function removeUser(user_name){
    $.ajax({
        url:'RemoveUser',
        data:{"user_name":user_name},
        type:'POST',
        dataType: "json",
        complete:function(){
            $( "#UserList" ).load( window.location.href+" #UserList" );
        }
    });
}


function login() {
    var username=document.getElementById("username");
    var password=document.getElementById("password");
    $.ajax({
        url: 'login',
        data:{"username":username.value,"password":password.value},
        type: 'GET',
        dataType:'text',
        success: function(response) {
            if(response=='invalid'){
                alert("Invalid User Name or Password");
                username.value="";
                password.value="";
            }
            else{
                window.location.href='Home.jsp?username='+username.value+'&type='+response;
            }
        }
    });
}

function logout() {
    window.location.href='index.jsp';
}