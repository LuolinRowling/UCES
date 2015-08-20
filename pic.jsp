<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8" />
		<title></title>
			
			<% List<String> picNum = (List<String>)request.getAttribute("picNum"); %>
	
			<script>
				var picNum=new Array();  //被考核基数学号
				var count =0;  //图片滚动
				var picSize;   //被考核基数总数
				var xueyuan;   //学院
				var fudaoyuan;   //辅导员
				var repeatNum=new Array();   //记录出现过的图片序号
				var repeatCount = 0; //记录重复出现数组大小
				
				 window.onload=function(){
						<%   for(int i=0;i<picNum.size();i++){   %> 
				        picNum[ <%=i%> ]= "<%=picNum.get(i)%>"; 
				<%   }   %>
				
				picSize = <%=picNum.size()%>;
				xueyuan ="<%= request.getAttribute("xueyuan")%>";
				fudaoyuan ="<%= request.getAttribute("fudaoyuan")%>";

				 }

		
				var flag ;
				function choose(obj){
					if(obj.innerHTML == "start"){
						obj.innerHTML = "stop";
						
						flag=window.setInterval("srcChange()",50);
						
					}else{
						obj.innerHTML = "start";	
						flag=window.clearInterval(flag);
						//先匹配，随机取出一张照片，并记录下来
						var exact;  //返回的随机数
						var repeatFlag = true;
						var randomNum;  //返回的随机数
						var flagCount ;
						while(repeatFlag){
							flagCount =0;
							randomNum = rand_range(0,picSize-1,exact);
							for(var j=0;j<repeatCount;j++){
								if(repeatNum[j] == randomNum){
									flagCount++;
								}
							}
							if(flagCount == 0){
								repeatFlag = false;
							}
							
						}
						//alert(randomNum);
						repeatNum[repeatCount] = randomNum;
						repeatCount++;
						
						//alert(randomNum);
					  	var url = "img/" +xueyuan+"/" + fudaoyuan + "/"+picNum[randomNum]+".jpg";
					  	document.getElementById("pic").value = picNum[randomNum];
					  	document.getElementById("pic").src = url;
					}
				}
				
				
			  function srcChange(){
				
			  	var url = "img/" +xueyuan+"/" + fudaoyuan + "/"+picNum[count%picSize]+".jpg";
			  	document.getElementById("pic").src = url;
			  	count++;
			  }
			  
				function rnd( seed ){
					seed = ( seed * 9301 + 49297 ) % 233280;
					return seed / ( 233280.0 );
					};

					function rand_range(min,max,exact){
					today = new Date();
					seed = today.getTime();
					if (arguments.length === 0)
					{
					return native_random();
					}
					else if (arguments.length === 1)
					{
					max = min;
					min = 0;
					}
					var range = min + (rnd( seed )*(max - min));
					return exact === void(0) ? Math.round(range) : range.toFixed(exact);
					};
					
				function getInfo(){
					  var result=null;
					  if(window.XMLHttpRequest)
					  {
					     result=new XMLHttpRequest();
					  }else if(window.ActiveXObject)
					  {
				     result=new ActiveXObject("Microsoft.XMLHttp");
		    			}

		    			if(result)
		    			{
		    				
		    				var pre="studentServlet?type=stuInfo&xuehao="+document.getElementById("pic").value;
		    				
		    				result.open("get",pre,true);
		    			
		    				result.onreadystatechange=function(){
						if(result.readyState==4&& result.status==200){
							//判断ajax返回结果
						var back  = result.responseText;
						//alert(back);
						
						var name = back.xuesheng[0].banJi;
						alert(name);
						}
		  				};
		  				result.send();

		    			}  
				}
		</script>

			
	</head>
	<body>
				
		<img id="pic" src="" style="height: 500px;width: 500px;" />
		<button onclick="choose(this)" >start</button>
		<button onClick=getInfo() >显示</button>
		<div id="info" style="display:none;">
			姓名：<p id="xingming"></p>
			宿舍号:<p id="sushehao"></p>
			生源地:<p id="shengyuandi"></p>
		</div>
		
	</body>
</html>