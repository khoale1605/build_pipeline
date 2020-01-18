<jsp:directive.include file="../include/taglibs.jsp" />
<c:set var="SiteURL" value="<%= request.getContextPath() %>"/>


<style type="text/css">
.nav>li>a {
	padding-top: 14px;
	padding-bottom: 15px;
	font-size: 15px;
}

</style>

<div class="sidebar">
	<div class="sidearea" style="overflow: auto; height: 866px;">

		<div class="navbar-default" role="navigation">
			<div class="sidebar-nav">
				<ul class="nav" id="side-menu">
					<li><a OnClick="location.href=&#39;<c:out value='${SiteURL}'/>/pms/changePassword&#39;"><spring:message code="screen.changePassword.title"/></a></li>
					<li><a OnClick="location.href=&#39;<c:out value='${SiteURL}'/>/pms/resetPassword&#39;"><spring:message code="screen.resetPassword.title"/></a></li>
				</ul>
			</div>
		</div>

		<div class="panel panel-info" id="msg-panel"
			style="margin-bottom: 0px;">
			<div class="panel-heading" id="msg-heading"
				style="font-weight: bolder; text-align: center; padding-right: 40px;">
				Messages</div>

			<div class="panel-body">
				<div class="row" style="padding:5px 10px !important;text-align: center">
					<p><spring:message code="com.csc.integral.portlet.footer.copyRight"/></p>
				</div>
			</div>
		</div>
	</div>
</div>

