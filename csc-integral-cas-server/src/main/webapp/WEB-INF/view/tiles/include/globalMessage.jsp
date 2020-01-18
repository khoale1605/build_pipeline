<jsp:directive.include file="taglibs.jsp" />
<style>
    .rb_left {
      background-image:url("<%= request.getContextPath() %>/screenFiles/roundedBox/bottom_left_dialog.PNG");
      background-repeat:no-repeat;
      float:left;
      height:19px;
      width:22px;
      border-width:0px;
    }

    .rb_right {
      background-image:url("<%= request.getContextPath() %>/screenFiles/roundedBox/bottom_right_dialog.PNG");
      background-repeat:no-repeat;
      float:left;
      height:19px;
      width:22px;
      border-width:0px;
    }
</style>
<c:if test="${not empty GLOBAL_MESSAGES}">
    <script type="text/javascript">
    $(function(){
          var message = '';
          <c:forEach items="${GLOBAL_MESSAGES}" var="msg">
              message += "<spring:message code='${msg.code}' arguments='${msg.params}'/><br/>";
          </c:forEach>
          $("body").append($("<div id='messageDialog'><font>" + message+ "</font></div>"));
          $("#messageDialog").dialog({ modal: true, draggable:true });
          $('.ui-dialog').css('padding', '0px');
          $(".ui-widget-header").css('background','url("/cas/screenFiles/roundedBox/bg_title_001.gif") repeat scroll 0 0 transparent');
          $(".ui-widget-header").css('border', 'none');
          $('.ui-corner-all').css('-moz-border-radius', '0px');
          $('.ui-widget-content').css('border', 'none');
          $('.ui-dialog-content').css('border', '1px solid #4d81b1');
          if($.browser.msie){
            $('.ui-dialog-content').css('border-bottom', '#4d81b1 0px solid');
            $('.ui-dialog').css('border-width', '0px');
            $('.ui-dialog .ui-dialog-titlebar').css('padding', '0.5em 1em 0.2em');
            $('.ui-dialog').append($(
                    '<div class="rb_left"></div>'
                  + '<div style="width:'+  ($('.ui-dialog').width() - 44) + 'px;background-color:white;background-image:none;border-bottom:1px solid #4D81B1;float:left;height:17px;"></div>'
                  + '<div class="rb_right"></div>'
                  ));
          }
          else {
            $('.ui-dialog .ui-dialog-titlebar').css('padding', '0.5em 1em 0.1em');
            $('.ui-dialog').css('-moz-border-radius', "0 0 15px 15px");
          }
    });
    </script>
</c:if>