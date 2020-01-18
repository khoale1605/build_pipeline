<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
	<head>
	    <title>CAS &#8211; Central Authentication Service</title>
	    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	    <style type="text/css" media="screen">@import '<%= request.getContextPath() %>/skin/style/common.css'/**/;</style>
	    <style type="text/css" media="screen">@import '<%= request.getContextPath() %>/skin/style/style.css'/**/;</style>
	    <style type="text/css" media="screen">@import '<%= request.getContextPath() %>/skin/IntegralStyle.css'/**/;</style>
	    <script src="http://code.jquery.com/jquery-1.4.4.js"></script>
<!-- 		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"> -->
	    
	    <link href='<%= request.getContextPath() %>/css/bootstrap.min.css' rel="stylesheet" type="text/css">
	    <link href='<%= request.getContextPath() %>/css/font-awesome.min.css'  rel="stylesheet" type="text/css">  
	     <link href='<%= request.getContextPath() %>/css/fontawesome-webfont.woff'  rel="stylesheet">  

		
	    
		<script language="JavaScript">
			$('span[id$=".errors"]').each(function() {
			     var fieldError = $(this).attr("id");
			     var field=fieldError.split(".errors");
			     if(document.getElementById(field[0]) != null){
			        document.getElementById(field[0]).style.background = "red";
			     }
			    });
		</script>
	    <style type="text/css">
	    
	    	/*header style*/
	    	.navbar{
				border-radius: 0px;
				margin: 0px;
				background-color: #2c2cce;
			}
			.logo p{
				display: table;
				color: #fff;
				font-weight: bold;
				font-size: 15px;
				padding: 2px 0 0 15px;
			}
			.logo{
				padding: 2px 0 0 15px;
				float: left;
				width: 300px;
			}
			.logo img{
				float: left;
			}
			.icon-menu{
				float: right;
				margin-top: 3px;	
			}
			.icon-menu a{
				float: left;
				margin-right: 30px;
			}
			.sidebar{
				max-width: 273px;
				background-color: #fff;
				border-right: solid 1px #cccccc;
				float: left;
			}
			.sidearea, .sidearea .navbar-default{
				width: 100%;
			}
			#msg-panel{
				margin-top: 200px;
			}
			.content{
				display: table;
			}
			.container{
				margin: 0; 
				width: 100%; 
				padding: 0;
			}
			.content h1{
				width: 100%;
				font-family: 'Oswald', sans-serif !important;
				font-weight: 500 !important;
				font-size: 24px !important; 
				border-bottom: 1px solid #eee !important;
				border-bottom-style: double !important;
				margin-bottom: 10px
			}

			/*body style*/
			
	    	
	    	/*table style*/
			.cursor{
				cursor: pointer;
			}

			.mainView {
				width: 990px;
				height: 755px;
				margin-top:7px;
				margin-left:5px;
			}

			.rb_content {
			      width: 700px;
				  margin-top: 7%;
				  margin-left: 8%;
			}

			.rb_content_bottom  .rb_left{
				background-image: url(<%= request.getContextPath() %>/screenFiles/roundedBox/bottom_left.PNG);
			}

			.rb_content_bottom .rb_right{
				background-image: url(<%= request.getContextPath() %>/screenFiles/roundedBox/bottom_right.PNG);
			}

			.rb_content_top {
            	background-color: rgba(52, 77, 90, 0.78) !important;
            	width: 100%;
			    height: 36px !important;
			    background-repeat: no-repeat;
			    BORDER-RIGHT: #4d81b1 1px solid;
			    BORDER-LEFT: #4d81b1 1px solid;
			}


			.rb_content_bottom {
				width: 102%;
			}

			.rb_content_bottom_area2 {
				width: 654px;
			}


			div.fct .rb_content_top{
				margin: 0px;
				width: 218px;
			}

			div.fct .rb_content_middle{
				height: 80px;
				margin: 0px;
				width: 218px;
			}

			div.fct .rb_content_bottom{
				margin: 0px;
				width: 220px;
			}

			div.fct .rb_content_bottom .rb_content_bottom_area2{
				margin: 0px;
				width: 176px;
			}

			.sectionbutton{
				width:160px;
				margin-top:10px;
				text-align: center;
			}

			.text{
				font-family:Arial;
				font-size:13;
				font-weight: bold;
			}

			.error-block{
				padding-left:12px;
				color: red;
			}

			.error{
				color: red;
				padding:0px;
				margin:0px;
				font-weight: bold;
			}

			.info{
				color: green;
				padding:0px;
				margin:0px;
				font-weight: bold;
			}
			
			/*change password layout*/
			
			.panel-heading {
	            padding: 10px 15px;
	            border-bottom: 1px solid transparent;
	            border-top-left-radius: 3px;
	            border-top-right-radius: 3px;
	            text-align: left;
	            font-weight: bold !important;
	            background-color: rgba(52, 77, 90, 0.78) !important;
	            color: #ffffff !important;
	            font-size: medium !important;
        	}
        
        	.input-group[class*=col-] {
    			float: left !important;
    		}
    		
    		.panel-body > button
	        {
	            float: left;
	            margin-left: 10px;
	        }
	        
	        .change-button-group {
			    float: right;
			   
			    margin-right: 29px;
			    margin-top: 10px;
    		} 
    		
    		.btn-submit
    		{
    			width: auto;
    			height: 35px;
    		}
    		
    		.exit-button
    		{
    		    padding-left: 0px;
    		}
    		
    		#msg-notify
    		{
    			padding-left: 0px;
    			padding-bottom: 10px;
    		}
    		
    		
		
	    </style>
	</head>

<div class="container" style="padding-left: 10px!importtant;>
	 <div id="portlet" class="mainView">
	 	<div id="header">
	 		<tiles:insertAttribute name="header" />
	 	</div>
	 
		<div class="row">
		 	<div class="col-sm-3" id="sidebar" style="float:left">
		 		<tiles:insertAttribute name="sidebar"/>
		 	</div>
		 	
		 	<div class="col-sm-9" id="body" >
		 		<tiles:insertAttribute name="body"/> 		
		 	</div>
		</div>
	
	</div>
	
</div>

</html>
