<%--
  Created by IntelliJ IDEA.
  User: 13368
  Date: 2020/3/8
  Time: 23:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="tree">
    <ul style="padding-left:0px;" class="list-group">
        <%--遍历显示父菜单--%>
        <c:choose>
            <c:when test="${empty pmenus}">
                <li class="list-group-item tree-closed" >
                    查询菜单失败
                </li>
            </c:when>
            <c:otherwise>
                <c:forEach items="${pmenus}" var="pmenu">
                    <c:choose>  <%--这个标签别忘了--%>
                        <c:when test="${empty pmenu.children}">
                            <li class="list-group-item tree-closed" >
                                <a href="${PATH}/${pmenu.url}"><i class="${pmenu.icon}"></i> ${pmenu.name}</a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="list-group-item tree-closed">
                                <span><i class="${pmenu.icon}"></i> ${pmenu.name} <span class="badge" style="float:right">${pmenu.children.size()}</span></span>
                                <ul style="margin-top:10px;display:none;">
                                    <c:forEach items="${pmenu.children}" var="child">
                                        <li style="height:30px;">
                                            <a href="${PATH}/${child.url}"><i class="${child.icon}"></i> ${child.name}</a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </c:otherwise>
        </c:choose>

    </ul>
</div>

<%--
<%@include file="/WEB-INF/pages/inculde/base_siderbar.jsp"%>
--%>
