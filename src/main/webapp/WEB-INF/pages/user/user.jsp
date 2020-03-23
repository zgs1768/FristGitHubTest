<%--
  Created by IntelliJ IDEA.
  User: 13368
  Date: 2020/3/8
  Time: 22:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <%@ include file="/WEB-INF/pages/inculde/base_css.jsp"%>

    <style>
        .tree li {
            list-style-type: none;
            cursor:pointer;
        }
        table tbody tr:nth-child(odd){background:#F4F4F4;}
        table tbody td:nth-child(even){color:#C00;}
    </style>
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 用户维护</a></div>
        </div>
        <%@include file="/WEB-INF/pages/inculde/base_loginbar.jsp"%>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
            <%@include file="/WEB-INF/pages/inculde/base_siderbar.jsp"%>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
                </div>
                <div class="panel-body">
                    <form action="${PATH}/admin/index" class="form-inline" role="form" style="float:left;">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input value="${param.condition}" name="condition" class="form-control has-success" type="text" placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button type="submit" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
                    </form>
                    <button type="button" onclick="batchDelAdmins();" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
                    <button type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='${PATH}/admin/add.html'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr >
                                <th width="30">#</th>
                                <th width="30"><input type="checkbox"></th>
                                <th>账号</th>
                                <th>名称</th>
                                <th>邮箱地址</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody>
<%--                            vs:遍历对象的状态--%>
                            <c:forEach items="${pageInfo.list}"  varStatus="vs" var="admin">
                                <tr>
                                    <td>${vs.count}</td>
                                    <td><input type="checkbox" id="${admin.id}"></td>
                                    <td>${admin.loginacct}</td>
                                    <td>${admin.username}</td>
                                    <td>${admin.email}</td>
                                    <td>
                                        <button type="button" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>
                                        <button adminid="${admin.id}" type="button" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>
                                        <button onclick="deleteAdmin(${admin.id})" type="button" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                            <tfoot>
                            <tr >
                                <td colspan="6" align="center">
                                    <ul class="pagination">
                                        <c:choose>
                                            <c:when test="${pageInfo.isFirstPage}">
                                                <li class="disabled"><a href="javascript:void(0);">上一页</a></li>
                                            </c:when>
                                            <c:otherwise>
                                                <li ><a href="${PATH}/admin/index?pageNumber=${pageInfo.pageNum-1}&condition=${param.condition}">上一页</a></li>
                                            </c:otherwise>
                                        </c:choose>
                                        <c:forEach items="${pageInfo.navigatepageNums}" var="num">
                                            <c:choose>
                                               <c:when test="${num==pageInfo.pageNum}">
<%--                                                   当前页高亮显示   点击标签不跳转--%>
                                                   <li class="active"><a href="javascript:void(0);">${pageInfo.pageNum} <span class="sr-only">(current)</span></a></li>
                                               </c:when>
                                                <c:otherwise>
                                                    <li><a href="${PATH}/admin/index?pageNumber=${num}&condition=${param.condition}">${num}</a></li>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                        <c:choose>
                                            <c:when test="${pageInfo.isLastPage}">
                                                <li class="disabled"><a href="javascript:void(0);">下一页</a></li>
                                            </c:when>
                                            <c:otherwise>
                                                <li ><a href="${PATH}/admin/index?pageNumber=${pageInfo.pageNum+1}&condition=${param.condition}">下一页</a></li>
                                            </c:otherwise>
                                        </c:choose>
                                    </ul>
                                </td>
                            </tr>

                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="/WEB-INF/pages/inculde/base_js.jsp"%>

<script type="text/javascript">
    $(function () {
        $(".list-group-item").click(function(){
            if ( $(this).find("ul") ) {
                $(this).toggleClass("tree-closed");
                if ( $(this).hasClass("tree-closed") ) {
                    $("ul", this).hide("fast");
                } else {
                    $("ul", this).show("fast");
                }
            }
        });
    });
    $("tbody .btn-success").click(function(){
        window.location.href = "assignRole.html";
    });
    $("tbody .btn-primary").click(function(){
        //获取所在行管理员id
        var adminid = $(this).attr("adminid");
        window.location.href = "${PATH}/admin/edit.html?id="+adminid;
    });

    $("a:contains('用户维护')").parents(".tree-closed").removeClass("tree-closed");

    $("a:contains('用户维护')").parents("ul:hidden").show();

    $("ul li a:contains('用户维护')").css("color","red");

    //删除管理员的单击事件
    function deleteAdmin(id) {
        // layer.msg(id);
         layer.confirm("你确定要删除吗?" ,{title:"删除提示"},function () {
          window.location = "${PATH}/admin/deleteAdmin?id="+id;
            layer.closeAll();
        })
    }
    //全选全不选
    $("table thead :checkbox").click(function () {
        $("table tbody :checkbox").prop("checked",this.checked) //设置标签的自带属性
    })
    // 子复选框任何一个被点击,都判断是否全选
    $("table tbody :checkbox").click(function () {
        var totalCount = $("table tbody :checkbox").length;
        var checkedCount = $("table tbody :checkbox:checked").length;
        $("table thead :checkbox").prop("checked",totalCount==checkedCount);
    })
    //管理员批量删除
    function batchDelAdmins(){
        var $checkedInps = $("table tbody :checkbox:checked"); //表示jquery对象
        //遍历集合,每个元素就是一个复选框的dom对象
        var idsArr = new Array();
        $.each($checkedInps,function () {
            idsArr.push(this.id);
        })
        var idsStr = idsArr.join(",");
        window.location = "${PATH}/admin/batchDelAdmins?ids="+idsStr;
    }


</script>
</body>
</html>
