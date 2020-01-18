<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% response.setHeader("Cache-Control","no-cache"); %>


<script type="text/javascript">
   function submit(url) {
    document.resetPasswordForm.action.value="resetPassword";
    document.resetPasswordForm.submit();
   }
   function submitonenter(evt,thisObj) {
       evt = (evt) ? evt : ((window.event) ? window.event : "")
      if (evt) {
           if ( evt.keyCode==13 || evt.which==13 ) {
               submit();
           }
       }
   }
</script>

<div class="rb_content" >
	<div class="rb_content_top">
		<p><img src="../images/csc/Input_icon02.png" height="25" title="Input"> <spring:message code="screen.resetPassword.title"/></p>
	</div>


	<div class="rb_content_middle" style="height: 300px;">
		 <div style="padding: 5px;">
             <form:form id="resetPasswordForm" modelAttribute="resetPasswordForm" name="resetPasswordForm" method="POST">
               <input type="hidden" name="action" value="N">
               
               <div class="panel-body">
                        <div class="row form-group">
                            <div class="col-md-3"> <label><spring:message code="screen.resetPassword.userName"/></label></div>
                            <div class="col-md-4 input-group">
                                <form:input path="userName" onkeypress="submitonenter(event,this);" id="userName" type="text" maxlength="20" class="form-control"/>
                            </div>
                             <div class="col-md-4">
                                 <span class="mandatory">*</span>
                 				<p class="error"><form:errors path="userName"/></p>
                 			 </div>
                        </div>
                        <div class="row form-group">
                                <div class="col-md-3"> <label><spring:message code="screen.resetPassword.systemUsername" /></label></div>
                                <div class="col-md-4 input-group">
                                    <form:input path="systemUsername" onkeypress="submitonenter(event,this);" id="systemUsername" type="text" maxlength="20" class="form-control"/>
                              </div>
                              <div class="col-md-4">
                                 <span class="mandatory">*</span>
                 				<p class="error"><form:errors  path="systemUsername"/></p>
                 			 </div>
                        </div>
                        <div class="row form-group">
                                <div class="col-md-3"> <label><spring:message code="screen.resetPassword.systemPassword"/></label></div>
                                <div class="col-md-4 input-group">
                                   <form:input path="systemPassword" onkeypress="submitonenter(event,this);" id="systemPassword" type="password" maxlength="20" class="form-control" autocomplete="off"/>
                             	</div>
                                 <div class="col-md-4">
                                 <span class="mandatory">*</span>
                 				<p class="error"><form:errors path="systemPassword"/></p>
                 			 </div>
                        </div>
                        
                        <div class="row">
							<div class="col-md-3"></div>
							<div class="col-md-4" id="msg-notify">
								 <c:if test="${msgStatus != null}">
					                <div class="info" style="width:400px;"><spring:message code="${msgStatus}"/></div>
					             </c:if>
					             <c:if test="${msgError != null}">
					                <div class="error" style="width:400px;">${msgError}</div>
					             </c:if>
							</div>
						</div>
						
						<div class="row form-group">
							<div class="col-md-3">
							</div>
							<div class="col-md-1 exit-button">
	                        	<button type="button" class="btn btn-danger"><a href="ams" style="color: white;"><spring:message code="screen.cancel"/></a></button>
							</div>
							<div class="col-md-2 input-group">
								<button type="button" class="btn btn-success btn-submit">
	                        	<p><a href="javascript:submit('resetPassword');" style="color: white;">
								<spring:message code="screen.resetPassword.resetPassword"/></a></p>
								</button>
							</div>
                        </div>
				</div>

				</div>
            </form:form>
  
          </div>
	
	<div class="rb_content_bottom">
		<div class="rb_left"></div>
		<div class="rb_content_bottom_area2" ></div>
		<div class="rb_right"></div>
	</div>

</div>