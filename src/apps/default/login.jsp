<%--
  ** Template for a login screen.
  ** @author Matthias L. Jugel
  ** @author Paulo Abrantes
  ** @version $Id: login.jsp 1716 2004-07-16 14:33:35Z leo $
  --%>

<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://snipsnap.com/snipsnap" prefix="s" %>

<div class="snip-wrapper">
 <div class="snip-title"><h1 class="snip-name"><fmt:message key="login.title"/></h1></div>
 <div class="snip-content">
  <s:check roles="Authenticated" invert="true">
   <%-- display error message --%>
   <c:if test="${error != null}">
    <div class="error"><fmt:message key="login.error"/></div>
    <div><b><fmt:message key="login.password.forgot"/> <a href="exec/forgot.jsp?login=<c:out value='${tmpLogin}'/>"><fmt:message key="login.password.reset"/></a></b></div>
    <c:if test="${app.configuration.allowRegister}">
      <div><b><fmt:message key="login.not.registered"/> <a href="exec/register.jsp?login=<c:out value='${tmpLogin}'/>"><fmt:message key="login.register.now"/></a></b></div>
    </c:if>
    <p/>
   </c:if>
   <%-- the login form --%>
   <c:if test="${app.configuration.featureSecureLoginEnabled == true}">
    <form class="form" method="post" action="<c:out value='https://${app.configuration.realHost}/${app.configuration.path}/exec/authenticate'/>" enctype="multipart/form-data">
   </c:if>
   <c:if test="${app.configuration.featureSecureLoginEnabled == false}">
     <form class="form" method="post" action="<c:out value='exec/authenticate'/>" enctype="multipart/form-data">
   </c:if>
   
    <table>
     <tr><td><label for="login"><fmt:message key="login.user.name"/></label></td><td><input id="login" name="login" type="text" size="20" value="<c:out value='${tmpLogin}'/>" tabindex="0"/></td></tr>
     <tr><td><label for="password"><fmt:message key="login.password"/></label></td><td><input id="password" name="password" type="password" size="20" value="" tabindex="0"/></td></tr>
     <tr><td class="form-buttons" colspan="2">
      <input value="<fmt:message key="login.dialog.login"/>" name="ok" type="submit" tabindex="0"/>
      <input value="<fmt:message key="dialog.cancel"/>" name="cancel" type="submit" tabindex="0"/>
     </td></tr>
    </table>
    <input name="referer" type="hidden" value="<c:out value='${referer}' default='${header["REFERER"]}'/>"/>
   </form>
  </s:check>

  <s:check roles="Authenticated">
    <fmt:message key="login.want.to.logoff"/>
  </s:check>
 </div>
</div>
