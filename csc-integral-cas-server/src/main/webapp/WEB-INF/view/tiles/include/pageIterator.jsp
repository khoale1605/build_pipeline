<jsp:directive.include file="../include/taglibs.jsp" />
<script type="text/javascript">
function loadPage(formToSubmit, i, action) {
    var hiddenField = document.createElement('input');
    hiddenField.setAttribute('type', 'hidden');
    hiddenField.setAttribute('name', 'pageNo');
    hiddenField.setAttribute('value', i);
    formToSubmit.appendChild(hiddenField);
    if(action != ""){
        formToSubmit.action=action;
    }
    formToSubmit.submit();
  }
</script>

<div class="UIPageIterator">
<c:set var="totalPage" value="${requestScope.pageList.availablePage}"></c:set>
<c:set var="currentPage" value="${requestScope.pageList.currentPage}"></c:set>

<input type="hidden" name="currentPage" value="${currentPage} "/>
<c:if test="${param.submitAction ne ''}">
    <portlet:actionURL escapeXml="false" var="pagingActionURL"><portlet:param name="action" value="${param.submitAction}"/></portlet:actionURL>
</c:if>
<c:if test="${totalPage gt 1}">

    <c:choose>
        <c:when test="${(currentPage + 10) le totalPage}">
            <a onclick="loadPage(<c:out value="${param.submitForm}"/>, <c:out value='${currentPage + 10}'/>, '<c:out value="${pagingActionURL}"/>');"
                    class="Icon NextTopPageIcon"
                    title="<spring:message code='UIPageIterator.label.nextTenPages'/>">

            </a>
        </c:when>
        <c:when test="${(pageList.currentPage + 1) le totalPage}">
            <a class="Icon DisableNextTopPageIcon"
                    title="<spring:message code='UIPageIterator.label.nextTenPages'/>"><span></span>
            </a>
        </c:when>
        <c:otherwise>
            <a class="Icon DisableNextTopPageIcon" title="<spring:message code='UIPageIterator.label.nextTenPages'/>"><span></span></a>
        </c:otherwise>
    </c:choose>
    <c:choose>
        <c:when test="${(currentPage + 1) le totalPage}">
            <a onclick="loadPage(<c:out value="${param.submitForm}"/>, <c:out value="${currentPage + 1}"/>, '<c:out value="${pagingActionURL}"/>');" class="Icon NextPageIcon" title="<spring:message code='UIPageIterator.label.next'/>"></a>
        </c:when>
        <c:otherwise>
            <a class="Icon DisableNextPageIcon" title="<spring:message code='UIPageIterator.label.next'/>"><span></span></a>
        </c:otherwise>
    </c:choose>

  <c:choose>
    <c:when test="${totalPage < 6}">
      <c:set var="min" value="1"></c:set>
      <c:set var="max" value="${totalPage}"></c:set>
    </c:when>
    <c:otherwise>
      <c:set var="min" value="${currentPage - 2}"></c:set>
      <c:set var="max" value="${currentPage + 3}"></c:set>
      <c:if test="${min lt 1}">
          <c:set var="max" value="${max + 1 - min}"></c:set>
          <c:set var="min" value="1"></c:set>
      </c:if>
      <c:if test="${max gt totalPage}">
          <c:set var="min" value="${min + totalPage - max}"></c:set>
          <c:set var="max" value="${totalPage}"></c:set>
      </c:if>
    </c:otherwise>
  </c:choose>

  <c:forEach var="i" begin="${min}" end="${max}" varStatus="status">
    <c:choose>
       <c:when test="${currentPage eq min + max - i}">
         <a class="Number PageSelected"><c:out value="${min + max - i}"/></a>
       </c:when>
       <c:otherwise>
         <a onclick="loadPage(<c:out value="${param.submitForm}"/>, <c:out value="${min + max - i}"/>, '<c:out value="${pagingActionURL}"/>');"
            class="Number"><c:out value="${min + max - i}"/>
         </a>
       </c:otherwise>
   </c:choose>
  </c:forEach>
    <c:choose>
        <c:when test="${(currentPage - 1) gt 0}">
            <a onclick="loadPage(<c:out value="${param.submitForm}"/>, <c:out value="${currentPage - 1}"/>, '<c:out value="${pagingActionURL}"/>');" class="Icon LastPageIcon" title="<spring:message code='UIPageIterator.label.previous' />"></a>
        </c:when>
        <c:otherwise>
            <a class="Icon DisableLastPageIcon" title="<spring:message code='UIPageIterator.label.previous' />"><span></span></a>
        </c:otherwise>
    </c:choose>
    <c:choose>
        <c:when test="${currentPage gt 10 }">
            <a onclick="loadPage(<c:out value="submitForm"/>, <c:out value="${currentPage - 10}"/>, '<c:out value="${pagingActionURL}"/>');" class="Icon LastTopPageIcon"
                title="<spring:message code='UIPageIterator.label.backTenPages'/>">
            </a>
        </c:when>
        <c:otherwise>
            <a class="Icon DisableLastTopPageIcon" title="<spring:message code='UIPageIterator.label.backTenPages'/>">
            </a>
        </c:otherwise>
    </c:choose>
    <a class="PagesTotalNumber"><c:out value="${totalPage}"/></a>
    <a class="TotalPages"><spring:message code='UIPageIterator.label.totalPage'/>: </a>
    <div class="ClearRight"><span></span></div>
</c:if>
</div>