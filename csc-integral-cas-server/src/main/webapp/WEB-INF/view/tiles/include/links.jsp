<%@page import="java.util.Locale"%>
<%@page import="java.util.HashMap"%>
<jsp:directive.include file="../include/taglibs.jsp" />
<div class="rb_content_top">
  <p>Links</p>
</div>
<div class="rb_content_middle">
<form name="form" method="post" >
    <div style="margin: 0px 0px 0px 15px;">

		<c:set var="locale" value="<%=response.getLocale().toString()%>" scope="request"/>
      <div style="padding:5px 0px 0px 0px">
        <div style="float:left; margin: 0px 18px 0px 0px;" OnClick="location.href='<%= request.getContextPath() %>/Help'" class="cursor">
            <p class="textBold"><spring:message code="screen.help"/></p>
        </div>
        <div style="float:left; margin: 0px 18px 0px 0px;"  OnClick="window.print();" class="cursor">
            <p class="textBold"><spring:message code="screen.print"/></p>
        </div>
        <div style="margin: 0px 18px 0px 0px;" OnClick="location.href='<%= request.getContextPath() %>/logout'" class="cursor">
            <p class="textBold"><spring:message code="screen.logout"/></p>
        </div>
      </div>
      <div style="margin: 5px 0px 0px 0px;" class="cursor">
        <select id="language" name="language" class="ActionButton LightBlueStyle" onchange="javascript:(changeLanguage());">
          <option value="us" <c:if test="${locale eq 'us'}">selected='selected'</c:if> ><spring:message code="screen.english"/></option>
          <option value="zh" <c:if test="${locale eq 'zh'}">selected='selected'</c:if> ><spring:message code="screen.chinese"/></option>
          <option value="ja" <c:if test="${locale eq 'ja'}">selected='selected'</c:if> ><spring:message code="screen.japanese"/></option>
          <option value="vi" <c:if test="${locale eq 'vi'}">selected='selected'</c:if> ><spring:message code="screen.vietnamese"/></option>
        </select>
      </div>
    </div>
</form>
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
<div class="rb_content_bottom">
  <div class="rb_left"></div>
  <div class="rb_content_bottom_area2"></div>
  <div class="rb_right"></div>
</div>