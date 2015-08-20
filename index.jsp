<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
  <head>
    <title>辅导员考核</title>
    <meta name="description" content="" />
    <meta name="author" content="templatemo">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
  
    
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/templatemo_misc.css">
   	<link type="text/css" rel="stylesheet" href="css/easy-responsive-tabs.css" />
    <link href="css/templatemo_style.css" rel="stylesheet"> 
        
	<script src="js/jquery-1.10.2.min.js"></script> 
	<script src="js/jquery.lightbox.js"></script>
	<script src="js/templatemo_custom.js"></script>
    <script src="js/easyResponsiveTabs.js" type="text/javascript"></script>  
     <script>
    function showhide()
    {
        
        $('#menu-container .homepage').fadeOut(1000, function(){
            $('#menu-container .about').fadeIn(1000);
    	    });
    		return true;
    	
    	
    }
    
    function getCookie(name){ 
    	var strCookie=document.cookie; 
    	var arrCookie=strCookie.split("; "); 
    	for(var i=0;i<arrCookie.length;i++){ 
    	var arr=arrCookie[i].split("="); 
    	if(arr[0]==name)return arr[1]; 
    	} 
    	return ""; 
    } 
    
	function delCookie(name) 
	{ 
	    var exp = new Date(); 
	    exp.setTime(exp.getTime() - 1); 
	    var cval=getCookie(name); 
	    if(cval!=null) 
	        document.cookie= name + "="+cval+";expires="+exp.toGMTString(); 
	} 
	
    window.onload=function(){
    	delCookie("tab-num");
    	//    	alert(document.cookie);
    }
  </script>
  </head>
  <body>
    	<!-- logo start -->
    <div class="logocontainer">
    	<div class="row">
        	<h1><a href="#">辅导员考核系统</a></h1>
            <div class="clear"></div>
            <div class="templatemo_smalltitle">****大学·*****</div>
       </div>
    </div>
    <!-- logo end -->    
   <div id="menu-container" class="main_menu">
   <!-- homepage start -->
    <div class="content homepage" id="menu-1">
  	<div class="container">
          	<div class="col-md-3 col-sm-6 templatemo_leftgap2">
              <div class="templatemo_mainabout templatemo_botgap templatemo_topgap" style="background-color:#4F94CD">
                 <div class="templatemo_link"><a href="teacherServlet?xueyuan=dianxin" >电信学院</a></div>
                </div>
                <div class="templatemo_mainabout templatemo_botgap" style="background-color:#009999">
                  <div class="templatemo_link"><a  href="teacherServlet?xueyuan=tujian">土建学院</a></div>
                </div>
                <div class="templatemo_mainabout" style="background-color:#cc3366">
                  <div class="templatemo_link"><a  href="teacherServlet?xueyuan=fa">法学院</a></div>
                </div>
            </div>
            <div class="col-md-3 col-sm-6 templatemo_leftgap2">
              <div class="templatemo_mainabout templatemo_botgap templatemo_topgap" style="background-color:#71C671">
                 <div class="templatemo_link"><a  href="teacherServlet?xueyuan=jisuanji">计算机学院</a></div>
                </div>
                <div class="templatemo_mainabout templatemo_botgap" style="background-color:#ff9933">
                  <div class="templatemo_link"><a  href="teacherServlet?xueyuan=jidian">机电学院</a></div>
                </div>
                <div class="templatemo_mainabout" style="background-color:#663399">
                  <div class="templatemo_link"><a  href="teacherServlet?xueyuan=yuyan">语传学院</a></div>
                </div>
            </div>
            <div class="col-md-3 col-sm-6 templatemo_leftgap2">
              <div class="templatemo_mainabout templatemo_botgap templatemo_topgap" style="background-color:#cc3366">
                 <div class="templatemo_link"><a  href="teacherServlet?xueyuan=jingguan">经管学院</a></div>
                </div>
                <div class="templatemo_mainabout templatemo_botgap" style="background-color:#009999">
                  <div class="templatemo_link"><a  href="teacherServlet?xueyuan=dianqi">电气学院</a></div>
                </div>
                <div class="templatemo_mainabout" style="background-color:#4F94CD">
                  <div class="templatemo_link"><a  href="teacherServlet?xueyuan=ruanjian">软件学院</a></div>
                </div>
            </div>
            <div class="col-md-3 col-sm-6 templatemo_leftgap2">
              <div class="templatemo_mainabout templatemo_botgap templatemo_topgap" style="background-color:#663399">
                 <div class="templatemo_link"><a  href="teacherServlet?xueyuan=yunshu">运输学院</a></div>
                </div>
                <div class="templatemo_mainabout templatemo_botgap" style="background-color:#ff9933">
                  <div class="templatemo_link"><a  href="teacherServlet?xueyuan=li">理学院</a></div>
                </div>
                <div class="templatemo_mainabout" style="background-color:#71C671">
                  <div class="templatemo_link"><a  href="teacherServlet?xueyuan=jianyi">建艺学院</a></div>
                </div>
            </div>
    </div>
    
   </div>
    <!-- homepage end -->

    </div>
    
    	<!-- logo start -->
    <div class="logocontainer">
    	<div class="row">
            <div class="templatemo_footer">Copyright © 2084 ****·**** - <a href="http://www.bjtu.edu.cn">****大学·*****</a> </div>
                   </div>
    </div>
    <!-- logo end -->  
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
    });
</script>

  </body>
</html>