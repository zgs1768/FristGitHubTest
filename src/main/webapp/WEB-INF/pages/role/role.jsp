<%--
  Created by IntelliJ IDEA.
  User: 13368
  Date: 2020/3/9
  Time: 14:25
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
            <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 角色维护</a></div>
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
                    <form class="form-inline" role="form" style="float:left;">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input id="queryRolesInp" class="form-control has-success" type="text" placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button type="button" id="queryRolesBtn" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
                    </form>
                    <button type="button" id="batchDelRolesBtn" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
                    <button type="button" class="btn btn-primary" style="float:right;" onclick="showAddModal()"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr >
                                <th width="30">#</th>
                                <th width="30"><input type="checkbox"></th>
                                <th>名称</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody>

                            </tbody>
                            <tfoot>
                            <tr >
                                <td colspan="6" align="center">
                                    <ul class="pagination">

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
<%--新增角色的模态框--%>
<div class="modal fade" id="addRoleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel">新增角色</h4>
      </div>
      <div class="modal-body">
        <form>
          <div class="form-group">
            <label  class="control-label">角色名:</label>
            <input type="text" class="form-control" name="name">
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button id="addRoleBtn" type="button" class="btn btn-primary">添加</button>
      </div>
    </div>
  </div>
</div>

<%--更新角色的模态框--%>
<div class="modal fade" id="updateRoleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" >更新角色</h4>
      </div>
      <div class="modal-body">
        <form>
            <input type="hidden" name="id">
          <div class="form-group">
            <label  class="control-label">角色名:</label>
            <input type="text" class="form-control" name="name">
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button id="updateRoleBtn" type="button" class="btn btn-primary">提交</button>
      </div>
    </div>
  </div>
</div>

<%--显示权限树的模态框--%>
<div class="modal fade" id="assignPermissionModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" >分配权限</h4>
      </div>
      <div class="modal-body">
        <ul class="ztree" id="permissionTree"></ul>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button id="assignPermissionBtn" type="button" class="btn btn-primary">分配</button>
      </div>
    </div>
  </div>
</div>


<%@include file="/WEB-INF/pages/inculde/base_js.jsp"%>
<script type="text/javascript">
    var pages;
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
        window.location.href = "assignPermission.html";
    });

//权限分配权限提交按钮
    var rid;
    var $ztreeObj;
    $("#assignPermissionBtn").click(function () {
        //ztree树对象 可以获取已经被勾选的 节点对象的集合
        var $checkedNodes = $ztreeObj.getCheckedNodes(true);
        console.log($checkedNodes)
        var pidsArr = new Array();//也就是权限结合
        $.each($checkedNodes,function () {
        pidsArr.push(this.id)
        })
        var pidsStr = pidsArr.join();
        $.ajax({
            type:"Post",
            url:"${PATH}/role/assginPermissions",
            data:{"roleid":rid,"permissionids":pidsStr},
            success:function (res) {
                if (res =="ok") {
                layer.msg("权限分配成功")
                $("#assignPermissionModal").modal("hide");
                }
            }
            }
        )
    });





    // 权限分配
    var setting = {
        check: {
		enable: true
			},
        data: {
		key: {
			name: "title"
		},
        simpleData: {
		enable: true,
		pIdKey: "pid",
		    }
		},
        view: {
		addDiyDom: function (treeId,treeNode) {
            $("#"+treeNode.tId+"_ico").remove();
            $("#"+treeNode.tId+"_span").before("<span class='"+treeNode.icon+"'></span>")
        }
	}
    };

    var zNodes;
    function assginRole(roleid) {
        rid = roleid;
        $.ajax({
            type:"GET",
            url:"${PATH}/role/getPermissions",
            success:function (permissions) {
                console.log(permissions);
                // 已选中权限json对象添加默认勾选
                 $.ajax({
                     type:"GET",
                     url:"${PATH}/role/getAssginedPermissionsIds",
                     data:{"roleid":roleid},
                     success:function (assignedPermissionids) {
                        $.each(permissions,function () {
                            if (assignedPermissionids.indexOf(this.id)>-1) {
                                this.checked = true;
                            }
                        });
                         zNodes = permissions;
                  $ztreeObj = $.fn.zTree.init($("#permissionTree"), setting, zNodes);
                $ztreeObj.expandAll(true);
                $("#assignPermissionModal").modal("toggle");
                     }
                 })
            }
        });
    }

// *****************************************************************************************
    //弹出模态框
    function showAddModal(){
        $("#addRoleModal").modal('show');
    }
    //角色添加按钮单击事件
    $("#addRoleModal #addRoleBtn").click(function () {
       $.ajax({
           type:"post",
           url:"${PATH}/role/addRole",
           data:$("#addRoleModal form").serialize(),  //表单序列化后可以直接提交
           success:function (result) {
                if (result == "ok") {
                     $("#addRoleModal").modal('hide');
                     layer.msg("角色创建成功");
                     initRoleTable(10000);
                }
           }
       });
    });
    //角色修改按钮单击事件
    function showUpdateRoleModal(roleid){
        $.ajax({
            type:"GET",
            url:"${PATH}/role/getRole",
            data:{"id":roleid},
            success:function (role) {
                $("#updateRoleModal form input[name='id']").val(role.id);
                $("#updateRoleModal form input[name='name']").val(role.name);
                $("#updateRoleModal").modal("show");
            }
        })
    }
    //更新角色提交按钮
    $("#updateRoleModal #updateRoleBtn").click(function () {
        $.ajax({
            type:"POST",
            url:"${PATH}/role/updateRole",
            data:$("#updateRoleModal form").serialize(),
            success:function (res) {
               if (res == "ok") {
                   $("#updateRoleModal").modal("hide");
                   layer.msg("更新成功");
                   var currentPageNum = $("#currentPageNum").text();
                   var condition = $("#queryRolesInp").val();
                    initRoleTable(currentPageNum,condition);
               }
            }
        })
    });
    //删除角色单击事件
    $("tbody").delegate(".deleteRoleBtn","click", function () {
       var roleid = $(this).attr("roleid");
        layer.confirm("你确定要删除吗?",{title:"删除确认"},function () {
            $.ajax({
                type:"GET",
                url:"${PATH}/role/delRole",
                data: {"id":roleid},
                success:function (res) {
                    if (res == "ok") {
                        layer.closeAll();
                        layer.msg("删除成功");
                        //刷新当前页面
                        var currentPageNum = $("#currentPageNum").text();
                        var condition = $("#queryRolesInp").val();
                        initRoleTable(currentPageNum,condition);
                    }
                }
            })
        })
    });
     //全选全不选
    $("table thead :checkbox").click(function () {
        $("table tbody :checkbox").prop("checked",this.checked)
    });
    $("table tbody").delegate(":checkbox","click",function () {
        $("table thead :checkbox").prop("checked",$("table tbody :checkbox").length == $("table tbody :checkbox:checked").length)
    });
    //批量删除
    $("#batchDelRolesBtn").click(function () {
        if ($("table tbody :checkbox:checked").length == 0) {
            layer.alert("请选择要删除的角色");
            return;
        }
         var idsArr= new Array();
        $("table tbody :checkbox:checked").each(function () {
            idsArr.push($(this).attr("roleid"));
        });
        var idsStr = idsArr.join(",");
        $.ajax({
            type:"GET",
            url:"${PATH}/role/batchDelRoles",
            data:{"ids":idsStr},
            success:function (result) {
                if (result=="ok") {
                    layer.msg("批量删除成功");
                    var currentPageNum = $("#currentPageNum").text();
                    var condition = $("#queryRolesInp").val();
                    initRoleTable(currentPageNum,condition);
                }
            }
        })
    });

    //侧边栏展开&选中高亮**************************************************************************************
    $("a:contains('角色维护')").parents(".tree-closed").removeClass("tree-closed");
    $("a:contains('角色维护')").parents("ul:hidden").show();
    $("ul li a:contains('角色维护')").css("color","red");

    //带条件的分页查询按钮
    $("#queryRolesBtn").click(function () {
        var condition = $("#queryRolesInp").val();
        initRoleTable(1,condition);
    });

    // 当前页面加载完成后,直接发ajax请求获取角色列表集合
    initRoleTable(1);

    //动态委派
    $("tfoot").delegate(".navA","click", function () {
        // 发起ajax请求获取角色分页对象
        var pageNum = $(this).attr("pageNum");
        var condition = $("#queryRolesInp").val();
        initRoleTable(pageNum,condition);
        return false;  //记得要取消默认行为
    });

    //异步加载role分页并解析
    function initRoleTable(pageNumber,condition) {
        $.ajax({
            type:"GET",
            url:"${PATH}/role/ListRoles",
            data:{"pageNumber":pageNumber,"condition":condition},
            success:function (pageInfo) {
                $("table thead :checkbox").prop("checked",false);
                pages = pageInfo.pages;
                // console.log(pageInfo);
                // 遍历生成角色集合的表格
                initRolesTbody(pageInfo);
                // 生成分页导航栏
                initNavTfoot(pageInfo);
            }
        })
    }

    function initNavTfoot(pageInfo){
        $("tfoot ul").empty();
        if (pageInfo.isFirstPage) {
            $('<li class="disabled"><a href="javascript:void(0);">上一页</a></li>').appendTo("tfoot ul");
        }else{
            $('<li ><a  class="navA" pageNum="'+(pageInfo.pageNum-1)+'" href="${PATH}/role/listRoles?pageNumber='+(pageInfo.pageNum-1)+'">上一页</a></li>').appendTo("tfoot ul");
        }
        $.each(pageInfo.navigatepageNums,function () {
            if (this==pageInfo.pageNum) {
                $('<li class="active"><a href="javascript:void(0);"><span id="currentPageNum">'+this+'</span><span class="sr-only">(current)</span></a></li>').appendTo("tfoot ul");
            }else{
                $('<li><a class="navA" pageNum="'+this+'" href="${PATH}/role/listRoles?pageNumber='+this+'">'+this+'</a></li>').appendTo("tfoot ul");
            }
        })
        if (pageInfo.isLastPage) {
            $('<li class="disabled"><a href="javascript:void(0);">下一页</a></li>').appendTo("tfoot ul");
        }else{
            $('<li ><a class="navA" pageNum="'+(pageInfo.pageNum+1)+'" href="${PATH}/role/listRoles?pageNumber='+(pageInfo.pageNum+1)+'">下一页</a></li>').appendTo("tfoot ul");
        }
        // $("tfoot .navA").click(function () {
        //      alert(this.href);
        //     return false;
        // });
    }
    
    function initRolesTbody(pageInfo) {
        $("tbody").empty();
        $.each(pageInfo.list,function (i) {
            $('<tr>'+
                '<td>'+(i+1)+'</td>'+
                '<td><input roleid="'+this.id +'" type="checkbox"></td>'+
                '<td>'+this.name+'</td>'+
                '<td>'+
                '<button onclick="assginRole('+this.id+')" type="button" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>'+
                '<button onclick="showUpdateRoleModal('+ this.id +')" type="button" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>'+
                '<button roleid="'+this.id+'" type="button" class="btn btn-danger btn-xs deleteRoleBtn"><i class=" glyphicon glyphicon-remove"></i></button>'+
                '</td>'+
                '</tr>').appendTo("table tbody");
        })
    }

</script>
</body>
</html>

