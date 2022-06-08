<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>detail</title>
<style>
    #movbox{
        width: 500px;
        padding: 30px;
        box-sizing: border-box;
        background-color: #eee;
    }
    .comm, #commAdd{
        width: 500px;
        padding: 30px;
        box-sizing: border-box;
        border: 1px solid #555;
        margin-bottom: 15px;
    }
</style>
<script>
    window.onload=function(){
        commList(1);
    }
    function commList(pageNum){
        let xhr=new XMLHttpRequest();
        xhr.onreadystatechange=function(){
            if(xhr.readyState==4&& xhr.status==200){
                let result=xhr.responseText;
                let commList=document.getElementById("commList");
                
                let childs=commList.childNodes;
                for(let i=childs.length-1; i>=0; i--){
                    let c=childs.item(i);
                    commList.removeChild(c);
                }
                
                let data=JSON.parse(result);
                let comm=data.list;
                for(var i=0; i<comm.length; i++){
                    let div=document.createElement("div");
                    div.innerHTML="아이디: "+ comm[i].id + "<br>"
                            + "내용: "+ comm[i].comments +  "<br>"
                            + "<a href='javascript:deleteComm("+ comm[i].num+")'>삭제</a>";
                    div.className="comm";
                    commList.appendChild(div);
                }
                
                let startPage=data.startPage;
                let endPage=data.endPage;
                let pageCount=data.pageCount;
                let pageHTML="";
                if(startPage>5){
                    pageHTML+="<a href='javascript:commList("+ (startPage-1)+")'>이전</a>"
                }
                for(let i=startPage; i<=endPage; i++){
                    if(i==pageNum){
                        pageHTML+="<a href='javascript:commList("+ i +")'><span style='color:blue'>["+ i +"]</span></a>"
                    }else{
                        pageHTML+="<a href='javascript:commList("+ i +")'><span style='color:gray'>["+ i +"]</span></a>"
                    }
                }
                if(endPage<pageCount){
                    pageHTML+="<a href='javascript:commList("+ (endPage+1)+")'>다음</a>";
                }
                let pageBox=document.getElementById("pageBox");
                pageBox.innerHTML=pageHTML;
                
            }
        }
        xhr.open('get',"${pageContext.request.contextPath}/comm/list?mnum=${mvo.mnum}&pagenum="+pageNum,true);
        xhr.send();
    }
    function addComm(){
    	let xhr=new XMLHttpRequest();
        let id=document.getElementById("id").value;
        let comments=document.getElementById("comments").value;
        xhr.onreadystatechange=function(){
            if(xhr.readyState==4 && xhr.status==200){
                let data=xhr.responseText;
                let json=JSON.parse(data);
                if(json.code== "success"){
                    commList(1);
                }else{
                    alert("등록실패.........");
                }
            }
        }
        xhr.open("post","${pageContext.request.contextPath}/comm/insert",true);
        xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
        let param= "id="+id+"&comments="+comments+"&mnum=${mvo.mnum}";
        xhr.send(param);
    }
    function deleteComm(num){
        let xhr=new XMLHttpRequest();
        xhr.onreadystatechange=function(){
            if(xhr.readyState==4 && xhr.status==200){
                let data=xhr.responseText;
                let json=JSON.parse(data);
                if(json.code=="success"){
                    commList(1);
                }else{  
                    alert("삭제실패.......");
                }
            }
        }
        xhr.open("post", "${pageContext.request.contextPath}/comm/delete?num="+num,true); 
        xhr.send();
    }
</script>
</head>
<body>
<div id="movbox">
    <h1>${mvo.title}</h1>
    <p>내용 : ${mvo.content}</p>
    <p>감독 : ${mvo.director}</p>
</div>
<div>
    <!-- 댓글목록이 보여질 div -->
    <div id="commList"></div>
    <div id="commAdd">
        아이디<br> 
        <input type="text" id="id"> <br>
        영화평<br> 
        <textarea id="comments" cols="50" rows="3"></textarea><br> 
        <input type="button" value="등록" onclick="addComm()">
    </div>
	<!--페이징-->
    <div id="pageBox"></div>
</div>
</body>
</html>