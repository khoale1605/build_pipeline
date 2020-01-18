<jsp:directive.include file="../include/taglibs.jsp" />
<c:set var="SiteURL" value="<%= request.getContextPath() %>"/>
<div class="rb_content_top">
  <p>
    QuickLinks
  </p>
</div>

<div class="rb_content_middle">
  <div class="menu cursor">
      <ul>
        <li OnClick="location.href=&#39;<c:out value='${SiteURL}'/>/pms/changePassword&#39;">
        <!-- <li OnClick="location.href='${flowExecutionUrl}&_eventId=changePasswordEvent'"> -->
        	<spring:message code="screen.changePassword.title"/>
        </li>
        <li OnClick="location.href=&#39;<c:out value='${SiteURL}'/>/pms/resetPassword&#39;">
        <!-- <li OnClick="location.href='${flowExecutionUrl}&_eventId=resetPasswordEvent'"> -->
        	<spring:message code="screen.resetPassword.title"/>
        </li>
      </ul>
  </div>
</div>

<div class="rb_content_bottom">
  <div class="rb_left"></div>
  <div class="rb_content_bottom_area2"></div>
  <div class="rb_right"></div>
</div>
