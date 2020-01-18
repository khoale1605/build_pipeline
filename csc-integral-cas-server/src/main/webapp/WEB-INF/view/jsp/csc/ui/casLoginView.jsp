<%@ page contentType="text/html; charset=UTF-8" %>
<jsp:directive.include file="includes/top.jsp" />
<c:set var="SiteURL" value="<%= request.getContextPath() %>"/>
<Script language="javascript" type="text/javascript">

function changeMouseover(thi){
   var sorce=thi.src;
   if(sorce.indexOf("_after")==-1){
   var img1 = new Image();
   img1.src=sorce.replace(".png","_hover.png");
   eval(thi.src=img1.src);
   }
}

function changeMouseout(thi){
   var sorce=thi.src;
   if(sorce.indexOf("_after")==-1){
   var img1 = new Image();
   img1.src=sorce.replace("_hover.png",".png");
   eval(thi.src=img1.src);
   }
}
</Script>
<form:form method="post" id="fm1" cssClass="fm-v clearfix" commandName="${commandName}" htmlEscape="true" autocomplete="off" onSubmit="login('${SiteURL}');"> <!-- ICAS-41 -->
	<div class="box" id="login">
		<!-- <spring:message code="screen.welcome.welcome" /> -->
		<!--h2><spring:message code="screen.welcome.instructions" /></h2-->
		<div class="row">
            <table cellspacing="0" cellpadding="0">
              <tr><td width="100px">
                <span style="font-family: Arial, Helvetica, sans-serif; font-size: 12px;"><spring:message code="screen.welcome.label.username" /></span>
              </td>
              </tr>
              <tr>
              <td>
                <c:if test="${not empty sessionScope.openIdLocalId}">
                <strong>${sessionScope.openIdLocalId}</strong>
                <input type="hidden" id="username" name="username" value="${sessionScope.openIdLocalId}" />
                </c:if>

                <c:if test="${empty sessionScope.openIdLocalId}">
                <spring:message code="screen.welcome.label.username.accesskey" var="userNameAccessKey" />
                <form:input cssClass="input_cell required" cssErrorClass="input_cell error" id="userid" tabindex="1" accesskey="${userNameAccessKey}" path="username" autocomplete="false" htmlEscape="true"
          style="width:109px; font-family: Lucida Console; border:1 solid #ccc;font-size: 12px; border-style:inset;	height:18px;" />
                </c:if>
              </td>
	        </tr>
	        </table>
        </div>
        <div class="row">
            <table cellspacing="0" cellpadding="0">
              <tr><td width="100px">
                <span style="font-family: Arial, Helvetica, sans-serif; font-size: 12px;"><spring:message code="screen.welcome.label.password" /></span>
              </td></tr>
              <tr><td>
                <spring:message code="screen.welcome.label.password.accesskey" var="passwordAccessKey" />
                <form:password cssClass="input_cell required" cssErrorClass="input_cell error" id="password" tabindex="2" path="password"  
                	accesskey="${passwordAccessKey}" htmlEscape="true" autocomplete="off"
          			style="width:109px; font-family: Lucida Console; border:1 solid #ccc;font-size: 12px; border-style:inset; height:18px;" />
              </td></tr>
            </table>
		</div>
		<br/> <!-- ICAS-18 -->
		<div class="row">
            <table cellspacing="0" cellpadding="0">
              <tr><td width="500px">
				<input type="hidden" name="lt" value="${loginTicket}" />
				<input type="hidden" name="execution" value="${flowExecutionKey}" />
                <!--<input type="hidden" name="lt" value="${flowExecutionKey}" />-->
                <input type="hidden" name="_eventId" value="submit" />
                <input id="loginId" type="image" class="btn-submit" style="border:0; padding-left:5px;" src="${SiteURL}/images/csc/<spring:message code="screen.welcome.button.login.filename" />"
                	border="0" onMouseOver="changeMouseover(this)" onMouseOut="changeMouseout(this)" /> <!-- ICAS-18 -->
            	<p><a href="${SiteURL}/pms"><spring:message code="screen.ams.title"/></a></p>
              </td>
              <td></td>
              <td width="300px" style="padding-right: 30px; padding-top: 20px;"> <!-- ICAS-18 -->
              	<p align="right" style="font-size:x-small;"><spring:message code="screen.product.info"/></p>
              </td></tr>
            </table>
		</div>
	</div>
<form:errors path="*" cssClass="errors" id="status" element="div" />
</form:form>

<!-- Start ... deep linking -->
<script>
function setCookie(name, value, days){ //set cookie value
var expireDate = new Date();
//set "expstring" to either future or past date, to set or delete cookie, respectively
var expstring=expireDate.setDate(expireDate.getDate()+parseInt(days))
document.cookie = name+"="+value+"; expires="+expireDate.toGMTString()+"; path=/";
}

function deleteCookie(c_name) {
    document.cookie = encodeURIComponent(c_name) + "=deleted; expires=" + new Date(0).toUTCString();
}

function getURLParameter(name) {
  return decodeURIComponent((new RegExp('[?|&]' + name + '=' + '([^&;]+?)(&|#|;|$)').exec(location.search)||[,""])[1].replace(/\+/g, '%20'))||null
}


deleteCookie("contractNo");
setCookie("contractNo","",365); 
deleteCookie("contractNoOnline");
setCookie("contractNoOnline","",365); 

//checkCookie();
</script>
<%
String auto = request.getParameter("auto");
if (auto != null && auto.equals("true")) {
%>
<script>
 var contractNo = getURLParameter('contractNo');
 setCookie("contractNo",contractNo,365); 
 document.getElementById('userid').value="underwr1";
 document.getElementById('password').value="underwr1";
 document.forms[0].submit();
</script>

 
<%
}
response.addHeader("X-Frame-Options", "DENY");
response.addHeader("Strict-Transport-Security", "max-age=31536000; includeSubDomains");
%>
<!-- End ... deep linking -->


<jsp:directive.include file="includes/bottom.jsp" />
