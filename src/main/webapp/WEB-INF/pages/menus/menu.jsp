<%--
  Created by IntelliJ IDEA.
  User: 13368
  Date: 2020/3/10
  Time: 14:16
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
	</style>
  </head>

  <body>

    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container-fluid">
        <div class="navbar-header">
           <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 许可维护</a></div>
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
              <div class="panel-heading"><i class="glyphicon glyphicon-th-list"></i> 权限菜单列表 <div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
			  <div class="panel-body">
					<%-- ztree显示ztree树的容器ul标签--%>
                  <ul id="treeDemo" class="ztree"></ul>
			  </div>
			</div>
        </div>
      </div>
    </div>
<%--    更新菜单模态框--%>
<div class="modal fade" id="updateMenuModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" >更新菜单</h4>
      </div>
      <div class="modal-body">
        <form>
          <input type="hidden" name="id">
          <div class="form-group">
            <label  class="control-label">菜单名称:</label>
            <input type="text" class="form-control" name="name">
          </div>
          <div class="form-group">
            <label  class="control-label">菜单图标:</label>
            <input type="text" class="form-control" name="icon">
          </div>
            <div class="form-group">
            <label  class="control-label">菜单url地址:</label>
            <input type="text" class="form-control" name="url">
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button id="updateMenuBtn" type="button" class="btn btn-primary">提交</button>
      </div>
    </div>
  </div>
</div>

<%--    添加菜单模态框--%>
<div class="modal fade" id="addMenuModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="addMenuModalLabel">新增菜单</h4>
      </div>
      <div class="modal-body">
        <form>
            <input type="hidden" name="pid">
          <div class="form-group">
            <label  class="control-label">菜单名称:</label>
            <input type="text" class="form-control" name="name">
          </div>
          <div class="form-group">
            <label  class="control-label">菜单图标:</label>
            <input type="text" class="form-control" name="icon">
          </div>
            <div class="form-group">
            <label  class="control-label">菜单url地址:</label>
            <input type="text" class="form-control" name="url">
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button id="addMenuBtn" type="button" class="btn btn-primary">提交</button>
      </div>
    </div>
  </div>
</div>


<%@include file="/WEB-INF/pages/inculde/base_js.jsp"%>
        <script type="text/javascript">
       /*     $(function () {
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

				var setting = {
					view: {
						selectedMulti: false,
						addDiyDom: function(treeId, treeNode){
							var icoObj = $("#" + treeNode.tId + "_ico"); // tId = permissionTree_1, $("#permissionTree_1_ico")
							if ( treeNode.icon ) {
								icoObj.removeClass("button ico_docu ico_open").addClass("fa fa-fw " + treeNode.icon).css("background","");
							}
						},
						addHoverDom: function(treeId, treeNode){
							var aObj = $("#" + treeNode.tId + "_a"); // tId = permissionTree_1, ==> $("#permissionTree_1_a")
							aObj.attr("href", "javascript:;");
							if (treeNode.editNameFlag || $("#btnGroup"+treeNode.tId).length>0) return;
							var s = '<span id="btnGroup'+treeNode.tId+'">';
							if ( treeNode.level == 0 ) {
								s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="#" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
							} else if ( treeNode.level == 1 ) {
								s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  href="#" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
								if (treeNode.children.length == 0) {
									s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="#" >&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
								}
								s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="#" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
							} else if ( treeNode.level == 2 ) {
								s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  href="#" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
								s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="#">&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
							}

							s += '</span>';
							aObj.after(s);
						},
						removeHoverDom: function(treeId, treeNode){
							$("#btnGroup"+treeNode.tId).remove();
						}
					},
					async: {
						enable: true,
						url:"tree.txt",
						autoParam:["id", "name=n", "level=lv"]
					},
					callback: {
						onClick : function(event, treeId, json) {

						}
					}
				};
				//$.fn.zTree.init($("#treeDemo"), setting); //异步访问数据

				var d = [{"id":1,"pid":0,"seqno":0,"name":"系统权限菜单","url":null,"icon":"fa fa-sitemap","open":true,"checked":false,"children":[{"id":2,"pid":1,"seqno":0,"name":"控制面板","url":"dashboard.htm","icon":"fa fa-desktop","open":true,"checked":false,"children":[]},{"id":6,"pid":1,"seqno":1,"name":"消息管理","url":"message/index.htm","icon":"fa fa-weixin","open":true,"checked":false,"children":[]},{"id":7,"pid":1,"seqno":1,"name":"权限管理","url":"","icon":"fa fa-cogs","open":true,"checked":false,"children":[{"id":8,"pid":7,"seqno":1,"name":"用户管理","url":"user/index.htm","icon":"fa fa-user","open":true,"checked":false,"children":[]},{"id":9,"pid":7,"seqno":1,"name":"角色管理","url":"role/index.htm","icon":"fa fa-graduation-cap","open":true,"checked":false,"children":[]},{"id":10,"pid":7,"seqno":1,"name":"许可管理","url":"permission/index.htm","icon":"fa fa-check-square-o","open":true,"checked":false,"children":[]}]},{"id":11,"pid":1,"seqno":1,"name":"资质管理","url":"","icon":"fa fa-certificate","open":true,"checked":false,"children":[{"id":12,"pid":11,"seqno":1,"name":"分类管理","url":"cert/type.htm","icon":"fa fa-th-list","open":true,"checked":false,"children":[]},{"id":13,"pid":11,"seqno":1,"name":"资质管理","url":"cert/index.htm","icon":"fa fa-certificate","open":true,"checked":false,"children":[]}]},{"id":15,"pid":1,"seqno":1,"name":"流程管理","url":"process/index.htm","icon":"fa fa-random","open":true,"checked":false,"children":[]},{"id":16,"pid":1,"seqno":1,"name":"审核管理","url":"","icon":"fa fa-check-square","open":true,"checked":false,"children":[{"id":17,"pid":16,"seqno":1,"name":"实名认证人工审核","url":"process/cert.htm","icon":"fa fa-check-circle-o","open":true,"checked":false,"children":[]}]}]}];
				$.fn.zTree.init($("#treeDemo"), setting, d);
            });*/


       $("a:contains('菜单维护')").parents(".tree-closed").removeClass("tree-closed");
       $("a:contains('菜单维护')").parents("ul:hidden").show();
       $("ul li a:contains('菜单维护')").css("color","red");

	// ztree生成的配置
	var settings = {
	    data: {
		simpleData: {
			enable: true,
			pIdKey: "pid",
		},
		key: {
			url:"UrlDisable"
		}
	},
        view: {
		addDiyDom: function (treeId,treeNode) {
                                //treeNode 调用此方法节点对象  tree节点所在的容器的id---之前自己创建的
            $("#" + treeNode.tId + "_a").prop("target","");

            var tid = treeNode.tId;
            $("#"+tid+"_ico").remove(); //当前节点显示的图标的span标签移除
            $("#"+tid+"_span").before("<span class='"+treeNode.icon+"'></span>");
        },
        addHoverDom: function (treeId,treeNode) {
		    var aObj = $("#" + treeNode.tId + "_a"); // tId = permissionTree_1, ==> $("#permissionTree_1_a")
							aObj.attr("href", "javascript:;");
							if (treeNode.editNameFlag || $("#btnGroup"+treeNode.tId).length>0) return;
							var s = '<span id="btnGroup'+treeNode.tId+'">';
							if ( treeNode.level == 0 ) {
							    //根节点,只能添加
								s += '<a onclick="addMenu('+treeNode.id+');" class="btn btn-info dropdown-toggle btn-xs " style="margin-left:10px;padding-top:0px;" href="javascript:;" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
							} else if ( treeNode.level == 1 ) {
							    //枝节点 修改
								s += '<a onclick="updateMenu('+treeNode.id+');" class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  href="javascript:;" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
								if (treeNode.children.length == 0) {
								    //枝节点节点无子节点可以删
									s += '<a onclick="delMenu('+treeNode.id+')" class="btn btn-info dropdown-toggle btn-xs " style="margin-left:10px;padding-top:0px;" href="javascript:;" >&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
								}   //添加
								s += '<a onclick="addMenu('+treeNode.id+');" class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="javascript:;" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
							} else if ( treeNode.level == 2 ) {  //叶子节点
							    //修改
								s += '<a onclick="updateMenu('+treeNode.id+');" class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  href="javascript:;" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
								//删除
								s += '<a onclick="delMenu('+treeNode.id+')" class="btn btn-info dropdown-toggle btn-xs " style="margin-left:10px;padding-top:0px;" href="javascript:;">&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
							}
							s += '</span>';
							aObj.after(s);
          /*
		     if ($("#"+treeNode.tId+"_btngroup").length>0) {
                 return;
             }
            $("#"+treeNode.tId+"_a").after("<span id='"+treeNode.tId+"_btngroup'><span class='glyphicon glyphicon-pencil'></span><span class='glyphicon glyphicon-remove'></span><span class='glyphicon glyphicon-plus'></span></span>")*/
        },
		removeHoverDom: function (treeId,treeNode) {
		    $("#btnGroup"+treeNode.tId).remove();
            // $("#"+treeNode.tId+"_btngroup").remove();
        }

	}
    };
	
	
	
	
	
	function updateMenu(id) {
	  // layer.msg("1111")
	  $.get("${PATH}/menu/getMenu",{"id":id},function (menu) {
        $("#updateMenuModal form [name='id']").val(menu.id);
        $("#updateMenuModal form [name='name']").val(menu.name);
        $("#updateMenuModal form [name='url']").val(menu.url);
        $("#updateMenuModal form [name='icon']").val(menu.icon);
        $("#updateMenuModal").modal("show");
      })
    }
    //菜单更新提交按钮
       $("#updateMenuBtn").click(function () {
         $.post("${PATH}/menu/updateMenu",$("#updateMenuModal form").serialize(),function (result) {
        if (result == "ok") {
          $("#updateMenuModal").modal("hide");
          layer.msg("更新成功");
          initMenuTree();
          $("#updateMenuModal form :text").val("");
        }
    })
    });
       
    function addMenu(id) {
        $("#addMenuModal form [name='pid']").val(id);
        $("#addMenuModal").modal("show");
    }
    //新增菜单模态框提交按钮单击事件
    $("#addMenuBtn").click(function () {
    $.post("${PATH}/menu/addMenu",$("#addMenuModal form").serialize(),function (result) {
        if (result == "ok") {
          $("#addMenuModal").modal("hide");
          layer.msg("新增成功");
          initMenuTree();
          $("#addMenuModal form :text").val("");
        }
    });
    });

	function delMenu(menuid) {
	    $.ajax({
            type:"GET",
            url:"${PATH}/menu/delMenu",
            data:{id:menuid},
            success:function (result) {
                if (result == "ok") {
                    layer.msg("删除成功");
                    initMenuTree();
                }
            }
        })
    }
	//异步请求获取要显示的数据集合
	var zNodes;

	initMenuTree();

	function initMenuTree(){
        $.ajax({
        type:"GET",
        url:"${PATH}/menu/getMenus",
        success:function (pMenus) {
            // zNodes =[{name:"系统权限菜单","children":pMenus}]
            zNodes = pMenus;
            zNodes.push({"id":0, "name":"系统权限菜单","icon":"glyphicon glyphicon-modal-window"});

           console.log(zNodes);

            //ztree插件 按照settings配置 解析zNodes数据,生成ztree树显示到ztree容器中
	var $ztreeOBJ = $.fn.zTree.init($("#treeDemo"), settings, zNodes);
	// 展开所有菜单
	$ztreeOBJ.expandAll(true);
        }
    })
    }

        </script>
  </body>
</html>

