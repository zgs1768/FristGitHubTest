<%--
  Created by IntelliJ IDEA.
  User: 13368
  Date: 2020/3/8
  Time: 14:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="jquery/jquery-2.1.1.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<script src="script/docs.min.js"></script>
<script src="script/back-to-top.js"></script>
<script src="layer/layer.js"></script>
<script src="ztree/jquery.ztree.all-3.5.min.js"></script>


<script type="text/javascript">

    //退出单击事件
    $("#logout").click(function () {
        layer.confirm("你真的要退出系统吗?",{title:"退出确认"},function () {
            window.location = "${PATH}/logout";
            layer.closeAll();
        },function () {
            layer.closeAll();
            layer.msg("取消退出");
        });
        return false;
    })     
</script>


<%--

<%@include file="/WEB-INF/pages/inculde/base_js.jsp"%>

--%>
