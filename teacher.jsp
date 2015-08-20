<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="team.cnvs.picroll.table.FuDaoYuan" %>
<%@ page import="team.cnvs.picroll.table.XueSheng" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>辅导员考核</title>
		<link rel="stylesheet" href="css/style.css" />
		<link rel="stylesheet" href="css/teacher_style.css" />
		
		    
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/templatemo_misc.css">
   	<link type="text/css" rel="stylesheet" href="css/easy-responsive-tabs.css" />
    <link href="css/templatemo_style.css" rel="stylesheet"> 
        
	<script src="js/jquery-1.10.2.min.js"></script> 
	<script src="js/jquery.lightbox.js"></script>
	<script src="js/templatemo_custom.js"></script>
	<script src="js/JSON.js"></script>
    <script src="js/easyResponsiveTabs.js" type="text/javascript"></script>  
    <script src="js/bootstrap.min.js"></script>
    
    <script type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.7.2.custom.min.js"></script>
<script type="text/javascript" src="js/jquery.chromatable.js"></script>
		
	
			<script>
				
				var picNum=new Array();  //被考核基数学号
				var count =0;  //图片滚动
				var picSize;   //被考核基数总数
				var xueyuan;   //学院
				var fudaoyuan;   //辅导员
				var repeatNum=new Array();   //记录出现过的图片序号
				var repeatCount = 0; //记录重复出现数组大小
				var flag ;
				 <% ArrayList<FuDaoYuan> teachers = (ArrayList<FuDaoYuan>)session.getAttribute("teachers"); %>
				 
				 	<% List<String> picNum = (List<String>)request.getAttribute("picNum"); %>
				 window.onload=function(){
		
					<% if(picNum !=null){%>
						<%   for(int i=0;i<picNum.size();i++){   %> 
				        picNum[ <%=i%> ]= "<%=picNum.get(i)%>"; 
				<%   }   %>
				
				picSize = <%=picNum.size()%>;
				xueyuan ="<%= request.getAttribute("xueyuan")%>";
				fudaoyuan ="<%= request.getAttribute("fudaoyuan")%>";
				
				<%String fudaoyuan = (String)session.getAttribute("fudaoyuan");%>
				<%if(fudaoyuan != null){%>
					var lefttab = document.getElementById("<%=fudaoyuan%>");
					lefttab.setAttribute("style", "background:url(images/templatemo_arrow_gap.png) no-repeat center right #CC3333");
					//window.scrollTo(lefttab.offsetLeft, lefttab.offsetTop);
					document.getElementById("return").innerHTML = document.getElementById("<%=fudaoyuan%>").innerHTML;
				<%}%>
				
				<%}%>
				 
				 }

		
				
				function choose(obj){
					<% if(picNum == null){%>
						alert("请选择一个辅导员老师。");
					<%}else{%>
					
					
					if(obj.innerHTML == "开始" ||　obj.innerHTML == "继续"){
						obj.innerHTML = "暂停";
						document.getElementById("showInfo").disabled = 'disabled';
						flag=window.setInterval("srcChange()",50);
						
					}else{
						obj.innerHTML = "继续";	
						document.getElementById("showInfo").disabled = '';
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
					<%}%>
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
		    				
		    				var pre="studentServlet?type=stuInfo&fudaoyuan="+"<%=(String)session.getAttribute("fudaoyuan")%>"+"&xuehao="+document.getElementById("pic").value;
		    				//alert(pre);
		    				result.open("get",pre,true);
		    				result.send(null);
		    				result.onreadystatechange=function(){
						if(result.readyState==4&& result.status==200){
							//判断ajax返回结果
					
							//alert(result.responseText);
							var jsonResp = result.responseText;
							var json = eval ("(" + jsonResp + ")");
							document.getElementById("xingming").innerHTML = json.xingMing;
							document.getElementById("sushehao").innerHTML = json.suSheHao;
							document.getElementById("xuehao").innerHTML = json.xueHao;
							document.getElementById("zhuanye").innerHTML = json.zhuanYe;
							document.getElementById("banji").innerHTML = json.banJi;
							document.getElementById("zhengzhimianmao").innerHTML = json.zhengZhiMianMao;
							
							document.getElementById("shengyuandi").innerHTML = json.shengYuanDi;
							document.getElementById("xuexipaiming").innerHTML = json.xueXiPaiMing;
							document.getElementById("jiatingjingji").innerHTML = json.jiaTingJingJi;
							document.getElementById("ganbu").innerHTML = json.ganBu;
							document.getElementById("qitaqingkuang").innerHTML = json.qiTaQingKuang;
							document.getElementById("fudaoqingkuang").innerHTML = json.fuDaoQingKuang;							

				
							//document.getElementById("info").style.display = 'block';
						
						
		
							}
		  				};
		  				
		    			}
		    		}  
				
				
				 function showInfo(){
					
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
		    				
		    				var pre="studentServlet?type=multiSearch&fudaoyuan="+"<%=(String)session.getAttribute("fudaoyuan")%>"+"&xuehao="+document.getElementById("chaxuehao").value+"&xingming="+document.getElementById("chaxingming").value+"&banji="+document.getElementById("chabanji").value+"&sushehao="+document.getElementById("chasushehao").value+"&zhengzhimianmao="+document.getElementById("chazhengzhimianmao").value+"&jiatingjingji="+document.getElementById("chajiatingjingji").value;
		    				//alert(pre);
		    				result.open("get",pre,true);
		    			
		    				result.onreadystatechange=function(){
						if(result.readyState==4&& result.status==200){
							//判断ajax返回结果
							
							//alert(result.responseText);
							var jsonResp = result.responseText;
							var json = eval ("(" + jsonResp + ")");
							
							//alert(json.length);
							
							
							//var tab1=document.getElementById("infoTable");//获得table的id 
							//var tbody=document.createElement("tbody");//创建tbody
			
							 	document.getElementById("totalNumber").innerHTML = json.length;
								var tab1 = document.getElementById("infoTable");
								var tbody =document.createElement("tbody");
							
								//alert(tab1.rows.length-1);
								for(var i=tab1.rows.length-1;i>=0;i--){
									tab1.deleteRow(i);
								}
								
								var tr = document.createElement("tr");
								var td1 = document.createElement("td");
								td1.innerHTML = "学号";
								var td2 = document.createElement("td");
								td2.innerHTML = "姓名";
								var td3 = document.createElement("td");
								td3.innerHTML = "班级";
								var td4 = document.createElement("td");
								td4.innerHTML = "宿舍";
								var td5 = document.createElement("td");
								td5.innerHTML = "政治面貌";
								var td6 = document.createElement("td");
								td6.innerHTML = "学家庭经济状况";
								var td7 = document.createElement("td");
								td7.innerHTML = "学习情况";
								var td8 = document.createElement("td");
								td8.innerHTML = "是否干部";
								
								td1.setAttribute("style","font-weight:bold;");
								td2.setAttribute("style","font-weight:bold;");
								td3.setAttribute("style","font-weight:bold;");
								td4.setAttribute("style","font-weight:bold;");
								td5.setAttribute("style","font-weight:bold;");
								td6.setAttribute("style","font-weight:bold;");
								td7.setAttribute("style","font-weight:bold;");
								td8.setAttribute("style","font-weight:bold;");
								
								tr.appendChild(td1);
								tr.appendChild(td2);
								tr.appendChild(td3);
								tr.appendChild(td4);
								tr.appendChild(td5);
								tr.appendChild(td6);
								tr.appendChild(td7);
								tr.appendChild(td8);
								
								tbody.appendChild(tr);
								
								var i;
								for(i=0;i<json.length;i++){ 
								var tr = document.createElement("tr");
								var td1 = document.createElement("td");
								td1.innerHTML = json[i].xueHao;
								td1.setAttribute("class","aPerson");
								td1.setAttribute("onclick",'aPersonInfo('+ json[i].xueHao +')');
								var td2 = document.createElement("td");
								td2.innerHTML = json[i].xingMing;
								td2.setAttribute("class","aPerson");
								td2.setAttribute("onclick",'aPersonInfo('+ json[i].xueHao +')');
								var td3 = document.createElement("td");
								td3.innerHTML = json[i].banJi;
								td3.setAttribute("class","aPerson");
								td3.setAttribute("onclick",'aPersonInfo('+ json[i].xueHao +')');
								var td4 = document.createElement("td");
								td4.innerHTML = json[i].suSheHao;
								td4.setAttribute("class","aPerson");
								td4.setAttribute("onclick",'aPersonInfo('+ json[i].xueHao +')');
								var td5 = document.createElement("td");
								td5.innerHTML = json[i].zhengZhiMianMao;
								td5.setAttribute("class","aPerson");
								td5.setAttribute("onclick",'aPersonInfo('+ json[i].xueHao +')');
								var td6 = document.createElement("td");
								td6.innerHTML = json[i].jiaTingJingJi;
								td6.setAttribute("class","aPerson");
								td6.setAttribute("onclick",'aPersonInfo('+ json[i].xueHao +')');
								var td7 = document.createElement("td");
								td7.innerHTML = json[i].xueXiPaiMing;
								td7.setAttribute("class","aPerson");
								td7.setAttribute("onclick",'aPersonInfo('+ json[i].xueHao +')');
								var td8 = document.createElement("td");
								td8.innerHTML = json[i].ganBu;
								td8.setAttribute("class","aPerson");
								td8.setAttribute("onclick",'aPersonInfo('+ json[i].xueHao +')');
								
								tr.appendChild(td1);
								tr.appendChild(td2);
								tr.appendChild(td3);
								tr.appendChild(td4);
								tr.appendChild(td5);
								tr.appendChild(td6);
								tr.appendChild(td7);
								tr.appendChild(td8);
								
								tbody.appendChild(tr);
				
								}
								
								//tbody.setAttribute("style","position:positive;height:100%;width:100%;overflow:auto;");
								
								//tbody.setAttribute("style","overflow-y:scroll;height:160px");
								tab1.appendChild(tbody);
								
								$(".aPerson").attr('data-toggle','modal');
								$(".aPerson").attr('data-target','#myModal');
								$(".aPerson").attr('style','cursor:pointer;');
								

								       $("#infoTable").chromatable({

								           width: "830px", // specify 100%, auto, or a fixed pixel amount
								           height: "160px",
								           scrolling: "yes" // must have the jquery-1.3.2.min.js script installed to use

								       });
								  
								   
		
						}
		  				};
		  				result.send();
		  				
		    			}
				 }
				
				 function searchXueHao(){
						<% if(picNum == null){%>
						alert("请选择一个辅导员老师。");
					<%}else{%>

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
		    				
		    				var pre="studentServlet?type=stuInfo&fudaoyuan="+"<%=(String)session.getAttribute("fudaoyuan")%>"+"&xuehao="+document.getElementById("searchXueHao").value;
		    				//alert(pre);
		    				result.open("get",pre,true);
		    				result.send(null);
		    				result.onreadystatechange=function(){
						if(result.readyState==4&& result.status==200){
							//判断ajax返回结果
					
							//alert(result.responseText);
							var jsonResp = result.responseText;
							var json = eval ("(" + jsonResp + ")");
							document.getElementById("xingming").innerHTML = json.xingMing;
							document.getElementById("sushehao").innerHTML = json.suSheHao;
							document.getElementById("xuehao").innerHTML = json.xueHao;
							document.getElementById("zhuanye").innerHTML = json.zhuanYe;
							document.getElementById("banji").innerHTML = json.banJi;
							document.getElementById("zhengzhimianmao").innerHTML = json.zhengZhiMianMao;
							
							document.getElementById("shengyuandi").innerHTML = json.shengYuanDi;
							document.getElementById("xuexipaiming").innerHTML = json.xueXiPaiMing;
							document.getElementById("jiatingjingji").innerHTML = json.jiaTingJingJi;
							document.getElementById("ganbu").innerHTML = json.ganBu;
							document.getElementById("qitaqingkuang").innerHTML = json.qiTaQingKuang;
							document.getElementById("fudaoqingkuang").innerHTML = json.fuDaoQingKuang;							

				
							//document.getElementById("info").style.display = 'block';
						
						
		
							}
		  				};
		  				
		    			}
					<%}%>
				 }
				 
				 
				 function aPersonInfo(xuehao){
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
		    				
		    				var pre="studentServlet?type=stuInfo&fudaoyuan="+"<%=(String)session.getAttribute("fudaoyuan")%>"+"&xuehao="+xuehao;
		    				//alert(pre);
		    				result.open("get",pre,true);
		    				result.send(null);
		    				result.onreadystatechange=function(){
						if(result.readyState==4&& result.status==200){
							//判断ajax返回结果
					
							//alert(result.responseText);
							var jsonResp = result.responseText;
							var json = eval ("(" + jsonResp + ")");
						 	document.getElementById("axingming").innerHTML = json.xingMing;
							document.getElementById("asushehao").innerHTML = json.suSheHao;
							document.getElementById("axuehao").innerHTML = json.xueHao;
							document.getElementById("azhuanye").innerHTML = json.zhuanYe;
							document.getElementById("abanji").innerHTML = json.banJi;
							document.getElementById("azhengzhimianmao").innerHTML = json.zhengZhiMianMao;
							
							document.getElementById("ashengyuandi").innerHTML = json.shengYuanDi;
							document.getElementById("axuexipaiming").innerHTML = json.xueXiPaiMing;
							document.getElementById("ajiatingjingji").innerHTML = json.jiaTingJingJi;
							document.getElementById("aganbu").innerHTML = json.ganBu;
							document.getElementById("aqitaqingkuang").innerHTML = json.qiTaQingKuang;
							document.getElementById("afudaoqingkuang").innerHTML = json.fuDaoQingKuang;	 					

				
							//document.getElementById("info").style.display = 'block';
						
						
		
							}
		  				};
		  				
		    			}
				 }
				 
				 function changeText(obj){
					 <%String fudaoyuan = (String)request.getAttribute("fudaoyuan");%>
					 <% if(fudaoyuan !=null){%>
					 if(obj.innerHTML == "返回"){
						 obj.innerHTML = document.getElementById("<%=fudaoyuan%>").innerHTML;
					 }else{
						 obj.innerHTML = "返回";
					 }
					 <%}%>
				 }
		</script>
		
	</head>
	<body>
	<div class="logocontainer">
    	<div class="row">
        	<h1>辅导员考核系统</h1>
            <div class="clear"></div>
            <div class="templatemo_smalltitle">北京交通大学·学生工作处</div>
       </div>
    </div>
    

    <!--services start -->
   <div class="content services" id="menu-2">
		<div class="container">
        	<div class="row templatemo_bordergapborder">
            	<div class="col-md-3 col-sm-12 templatemo_leftgap">
                	<div class="templatemo_mainimg templatemo_botgap"><img src="images/templatemo_service1.jpg" alt="service image"></div>
                    <div class="templatemo_mainservice templatemo_botgap">
                	<div class="templatemo_linkservice"><a class="show-1 templatemo_homeservice" href="#">返回</a></div>
                </div>
                </div>
                
                <div class="templatemo_col37 col-sm-12 templatemo_leftgap">
                	<div class="templatemo_graybg">
                    <div class="templatemo_frame">
                	<h2>Our Services</h2>
                    <div class="clear"></div>
                    <p><a href="#">Matrix HTML5 template</a> is new metro style <a href="#">website template</a> for you and it is available for free download. Credit goes to <a rel="nofollow" href="#">Unsplash</a> for all images used in this template. Praesent ut vehicula lorem. Nulla nec tellus id ligula egestas luctus fringilla vel dui. Nulla quis quam eget purus aliquam molestie. Nunc ligula magna, viverra eu eros vitae, aliquam tempor nunc. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.<br><br>
					Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Suspendisse eget laoreet nunc. Suspendisse condimentum metus neque, at adipiscing metus venenatis eu. Mauris sit amet erat laoreet, ullamcorper justo sit amet, vehicula purus. Nulla sagittis pulvinar erat, sit amet venenatis lacus fringilla vitae.<br><br>
					Integer sit amet libero sed dui pretium tempor. Nam neque erat, euismod ut pulvinar in, bibendum eget mi. Phasellus porttitor purus sit amet condimentum mattis. Nulla non venenatis mauris.</p>
                    </div>
               	  </div>
              </div>
                <div class="templatemo_col37 col-sm-12 templatemo_leftgap templatemo_topgap">
                	<div class="templatemo_mainimg templatemo_botgap"><img src="images/templatemo_service2.jpg" alt="service image"></div>
                </div>
            </div>
        </div>
     </div>
	    
    <!-- services end -->	
     <div class="copyrights">Collect from <a href="http://www.cssmoban.com/">网页模板</a></div>
     <!-- about start -->
    <div class="content about" id="menu-5" style="display: block;">
    	<div class="container">
        	<div class="row templatemo_bordergapborder">
            <!--vertical Tabs-->
      		<div id="ab" class="resp-vtabs" style="display: block; width: 100%; margin: 0px;">
            <div class="col-md-3 col-sm-12 templatemo_leftgap_about">
            <div class="templatemo_frame1">
            <ul class="resp-tabs-list templatemo_tab">
            	<% if (teachers != null) {%>
                <% for(int i=0;i<teachers.size();i++){ %>
               <a href="studentServlet?type=allStudent&fudaoyuan=<%=teachers.get(i).getPinYin()%>" ><li id="<%=teachers.get(i).getPinYin()%>" class="resp-tab-item" aria-controls="tab_item-0" role="tab"><%=teachers.get(i).getXingMing()%></li></a>
                <%} %>
                <%} %>
            </ul>
            </div>
            <div class="templatemo_aboutlinkwrapper">
     		<div class="templatemo_link"><a class="show-1 templatemo_homeabout" href="index.jsp" id="return" onmouseout="changeText(this)" onmouseover="changeText(this)">返回</a></div>
            </div>
            </div>
<div class="resp-tabs-container templatemo_aboutcontainer">
                <h2 class="resp-accordion resp-tab-active" role="tab" aria-controls="tab_item-0"><span class="resp-arrow"></span>辅导员1</h2><div class="resp-tab-content resp-tab-content-active" aria-labelledby="tab_item-0" style="display:block">

                <ul id="myTab1" class="nav nav-tabs">
                        <li class="active" style="width:50%;text-align: center;"><a href="#qs1" data-toggle="tab" aria-expanded="false">基础测试</a></li>
                      
                        <li style="width:50%;text-align: center;" class=""><a href="#qs3" data-toggle="tab" aria-expanded="true">综合查询</a></li>
                    </ul>

                    <div id="myTabContent" class="tab-content">
                        <div class="tab-pane fade active in" id="qs1">
                            <div class="templatemo_col50 templatemo_rightgap_about" style="width:33.3%;">
                      <div class="templatemo_graybg templatemo_botgap">
                        <div class="templatemo_frame">
                      <div class="row">
                            <div class="col-sm-6 col-md-4" style="width:100%">
                                <div class="thumbnail">
                                <img id="pic" src="images/BJTU.png" style="height: 240px;width: 320px;" />
                                   
                                         <div class="caption">
                                                <center>
                                                    <p>
                                                    <button onclick="choose(this)" class="btn btn-primary">开始</button> 
                                                    <button id="showInfo" class="btn btn-default" onClick="getInfo()" disabled="disabled">显示</button>
                                                    </p>
                                                </center>
                                        </div>
                                </div>
                            </div>
                            <div>
                            <center>
                            	<p><input id="searchXueHao" placeholder="学号" type="text" style="width:140px;height:35px" maxlength="8"/>
                            	 <button onclick="searchXueHao()" class="btn btn-primary">查询</button> </p>
                            	 </center>
                            </div>
                        </div>
                        </div>
                        </div>
                    </div>
                <div class="templatemo_col50 templatemo_leftgap templatemo_botgap" style="width:66.7%">
                   
                    <div class="templatemo_graybg templatemo_botgap">
                        <div>
                          <table class="table table-bordered" style="margin-bottom: 0px;">
                            <caption style="font-size:25px;"><strong>学生详细信息</strong></caption>
                            <tbody>
                            <tr>
                               <td style="width:20%;" >学号</td>
                               <td id="xuehao"></td>
                               <td style="width:20%;">姓名</td>
                               <td id="xingming"></td>
                            </tr>
                            <tr>
                               <td style="width:20%;">班级</td>
                               <td id="banji"></td>
                               <td style="width:20%;">宿舍号</td>
                               <td id="sushehao"></td>
                            </tr>
                            <tr>
                               <td style="width:20%;">专业</td>
                               <td id="zhuanye"></td>
                               <td style="width:20%;">生源地</td>
                               <td id="shengyuandi"></td>
                            </tr>
                            <tr>
                               <td style="width:20%;">政治面貌</td>
                               <td id="zhengzhimianmao"></td>
                               <td style="width:20%;">学习排名</td>
                               <td id="xuexipaiming"></td>
                            </tr>
                            <tr>
                               <td style="width:20%;">家庭经济情况</td>
                               <td id="jiatingjingji"></td>
                               <td style="width:20%;">是否为学生干部</td>
                               <td id="ganbu"></td>			
                            </tr>
                          </tbody>
                          </table>
                          <table class="table table-bordered" style="margin-bottom: 8px;">
                            <tbody>
                            <tr style="height:60px">
                               <td style="height:60px;vertical-align: middle;width:30%;">其他情况：</td>
                               <td  ><div id="qitaqingkuang" style="vertical-align: middle;text-align: left;overflow-y:scroll;height:60px;"></div></td>
                            </tr>
                            <tr style="height:60px">
                               <td style="height:60px;vertical-align: middle;width:30%;">辅导情况：</td>
                               <td  ><div id="fudaoqingkuang" style="vertical-align: middle;text-align: left;overflow-y:scroll;height:60px;"></div></td>
                            </tr>
                          </tbody>
                          </table>
                   
                          
                        </div>
                    </div>
                </div>
                        </div>
<!--                         <div class="tab-pane fade" id="qs2">
                            <div class="templatemo_col50 templatemo_rightgap_about" style="width:33.3%;">
                      <div class="templatemo_graybg templatemo_botgap">
                        <div class="templatemo_frame">
                      <div class="row">
                            <div class="col-sm-6 col-md-4" style="width:100%">
                                <div class="thumbnail">
                                     <img data-src="holder.js/300x300" alt="..." src="images/BJTU.png">
                                         <div class="caption">
                                             <h3>交大22</h3>
                                                <center>
                                                    <p><a href="#" class="btn btn-primary" role="button">开始</a> <a href="#" class="btn btn-default" role="button">暂停</a></p>
                                                </center>
                                        </div>
                                </div>
                            </div>
                        </div>
                        </div>
                        </div>
                    </div>
                <div class="templatemo_col50 templatemo_leftgap templatemo_botgap" style="width:66.7%">
                    <p style="color:red">22222222222222222</p>
                </div>
                        </div> -->
                        <div class="tab-pane fade " id="qs3">
<div class="templatemo_col50 templatemo_rightgap_about" style="width:100%;">
                              <div class="templatemo_graybg templatemo_botgap">
                                <div>
                                  <!--下面插入查询的部分-->
                                  <div style="margin-top:8px;">
                                  <form id="form1" name="form1" method="post">
                                  <table class="table table-bordered" style="margin-bottom: 0px;">
                                    <caption style="font-size:20px;"><strong>信息查询</strong></caption>
                                    <tbody class="form-inline">
                                    <tr>
                                       <td align="right">
                                        <label for="textfield">学号：</label>
                                        <input style="width:150px;" class="form-control" type="text" name="xuehao" id="chaxuehao"></td>
                                       <td align="right">
                                       <label for="textfield">姓名：</label>
                                        <input style="width:150px;" class="form-control" type="text" name="xingming" id="chaxingming"></td>
                                       <td align="right"><label for="textfield">班级：</label>
                                        <input style="width:150px;" class="form-control" type="text" name="banji" id="chabanji"></td>
                                    </tr>
                                    <tr>
                                       <td align="right"><label for="textfield">宿舍号：</label>
                                        <input style="width:150px;" class="form-control" type="text" name="sushehao" id="chasushehao"></td>
                                       <td align="right"><label for="textfield">政治面貌：</label>
                                        <input style="width:150px;" class="form-control" type="text" name="zhengzhimianmao" id="chazhengzhimianmao"></td>
                                       <td align="right"><label for="textfield">家庭经济状况：</label>
                                        <input style="width:150px;" class="form-control" type="text" name="jiatingjingji" id="chajiatingjingji"></td>
                                    </tr>
                                  </tbody>
                                </table>
                                 </form>
                                <center>
                                  <button class="btn btn-primary" style="margin-top:10px;width:100px;" name="submit" id="submit" onclick="showInfo()">查询</button>
                                </center>
                               
                                  </div>
                                  <!--查询部分结束了哦-->
                                  <hr >
                                  <div style="display:block;float:right">总计：<span id="totalNumber"></span>条</div>
                                  <!--下面的是结果的部分-->
                                  <div style="margin-top:8px;">
                                    <table id="infoTable" class="table table-bordered" style="margin-bottom: 0px;">
                       
                                    </table>
                                  </div>
                                  <!--木有结果了哦-->
                                </div>
                              </div>
                            </div>
                        </div>
                    </div>
            </div>

            </div>
        </div>
			<div class="col-sm-12 templatemo_leftgap templatemo_aboutlinkwrapper1">
                	<div class="templatemo_aboutback templatemo_botgap">
                	<div class="templatemo_link"><a class="show-1 templatemo_homeabout" href="#">Go Back</a></div>
                </div>
                </div>
    </div>
            </div>
    </div>
    <!-- about end -->
    </div>
    <div class="logocontainer">
    	<div class="row">
            <div class="templatemo_footer">Copyright © 2084 BJTU·CNVS - <a href="http://www.bjtu.edu.cn">北京交通大学·学生工作处</a> </div>
       </div>
    </div>

  <!-- Modal -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		        <h4 class="modal-title" id="myModalLabel">学生详细信息</h4>
		      </div>
		      <div class="modal-body">
		   
                          <table class="table table-bordered" style="margin-bottom: 0px;">
                           
                            <tbody>
                            <tr >
                               <td style="width:20%;" >学号</td>
                               <td id="axuehao"></td>
                               <td style="width:20%;">姓名</td>
                               <td id="axingming"></td>
                            </tr>
                            <tr>
                               <td style="width:20%;">班级</td>
                               <td id="abanji"></td>
                               <td style="width:20%;">宿舍号</td>
                               <td id="asushehao"></td>
                            </tr>
                            <tr>
                               <td style="width:20%;">专业</td>
                               <td id="azhuanye"></td>
                               <td style="width:20%;">生源地</td>
                               <td id="ashengyuandi"></td>
                            </tr>
                            <tr>
                               <td style="width:20%;">政治面貌</td>
                               <td id="azhengzhimianmao"></td>
                               <td style="width:20%;">学习排名</td>
                               <td id="axuexipaiming"></td>
                            </tr>
                            <tr>
                               <td style="width:20%;">家庭经济情况</td>
                               <td id="ajiatingjingji"></td>
                               <td style="width:20%;">是否为学生干部</td>
                               <td id="aganbu"></td>			
                            </tr>
                          </tbody>
                          </table>
                          <table class="table table-bordered" style="margin-bottom: 8px;">
                            <tbody>
                           <tr style="height:60px">
                               <td style="height:60px;vertical-align: middle;width:30%;">其他情况：</td>
                               <td><div id="aqitaqingkuang" style="vertical-align: middle;text-align: left;overflow-y:scroll;height:60px;"></div></td>
                            </tr>
                            <tr style="height:60px">
                               <td style="height:60px;vertical-align: middle;width:30%;">辅导情况：</td>
                               <td><div id="afudaoqingkuang" style="vertical-align: middle;text-align: left;overflow-y:scroll;height:60px;"></div></td>
                            </tr>
                          </tbody>
                          </table>
                   
                          
                   
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		      </div>
		    </div><!-- /.modal-content -->
		  </div><!-- /.modal-dialog -->
		</div><!-- /.modal -->

     <script type="text/javascript">

    $(document).ready(function () {
        $('#horizontalTab').easyResponsiveTabs({
            type: 'default', //Types: default, vertical, accordion
            width: 'auto', //auto or any width like 600px
            fit: true, // 100% fit in a container
            closed: 'accordion', // Start closed if in accordion view
            activate: function(event) { // Callback function if tab is switched
                var $tab = $(this);
                var $info = $('#tabInfo');
                var $name = $('span', $info);

                $name.text($tab.text());

                $info.show();
				
            }
        });

        $('#ab').easyResponsiveTabs({
            type: 'vertical',
            width: 'auto',
            fit: true,
        });
		

		$('#cmt').easyResponsiveTabs({
            type: 'vertical',
            width: 'auto',
            fit: true,
        });
		
		 $('#myModal').modal(options);
    });
</script>

   
	</body>
</html>
