<%@page import="java.util.Locale"%>
<%@page import="java.util.HashMap"%>
<jsp:directive.include file="../include/taglibs.jsp" />

<div class="header" style="width: 100%">
	<nav class="navbar navbar-inverse">
		<div class="logo">
				<img src="<%= request.getContextPath() %>/images/csc/dxc_symbol_wht_rgb_150.png" width="55px"
				border="0">
			<p>INTEGRAL Admin</p>
		</div>
		
		<form name="form" method="post" >
			<c:set var="locale" value="<%=response.getLocale().toString()%>" scope="request"/>
			<div class="icon-menu">
				<a OnClick="location.href='<%=request.getContextPath()%>/Help'" class="cursor" style="color: #fff;font-size:20px !important;top:2px;" title="Help"><i class="fa fa-question-circle" style="color:white;"></i></a>
				<a OnClick="window.print();" class="cursor" style="color: #fff;font-size:20px !important;top:2px;" title="Print"><i class="fa fa-print" style="color:white;"></i></a>				 
				<a OnClick="location.href='<%= request.getContextPath() %>/logout'" class="cursor" style="color: #fff;font-size:20px !important;top:2px;" title="Logout"><i class="fa fa-sign-out" style="color:white;"></i></a>
				<a> <select class="form-group select-header form-control" name="language" id="language" onchange="javascript:(changeLanguage());">
					<option value="us" <c:if test="${locale eq 'us'}">selected='selected'</c:if> ><spring:message code="screen.english"/></option>
	          		<option value="zh" <c:if test="${locale eq 'zh'}">selected='selected'</c:if> ><spring:message code="screen.chinese"/></option>
	          		<option value="ja" <c:if test="${locale eq 'ja'}">selected='selected'</c:if> ><spring:message code="screen.japanese"/></option>
	          		<option value="vi" <c:if test="${locale eq 'vi'}">selected='selected'</c:if> ><spring:message code="screen.vietnamese"/></option>
			</select>
			</a>
			</div>
		</form>
	</nav>
</div>

<script type="text/javascript">
function changeLanguage() {
	newLanguage = form.language.options[form.language.selectedIndex].value;
	location_of_locale = window.location.href.indexOf("locale=");
	if (location_of_locale == -1) {
		if (window.location.href.indexOf("?") == -1) {
			window.location = window.location.href + '?locale=' + newLanguage;
		} else {
			window.location = window.location.href + '&locale=' + newLanguage;
		}
	} else {
		window.location = window.location.href.substr(0, location_of_locale) + 'locale=' + newLanguage;
	}
}
</script>
