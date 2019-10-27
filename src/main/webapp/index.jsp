<%--
  Created by IntelliJ IDEA.
  User: Sunny
  Date: 2019/10/21
  Time: 11:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% pageContext.setAttribute("APP_Path", request.getContextPath()); %>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>员工列表</title>
    <script src="${APP_Path}/static/js/jquery-3.4.1.min.js"></script>
    <link href="${APP_Path}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_Path}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js" type="text/javascript"></script>
</head>
<body>

<!-- Modal  员工修改的模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                            <span class="help-block" ></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@123.com">
                            <span class="help-block" ></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender_update_input" value="M" checked="checked">男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender_update_input02" value="F">女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_update_input" class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_update_select"></select>
                        </div>
                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                            <span class="help-block" ></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@123.com">
                            <span class="help-block" ></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender_add_input" value="M" checked="checked">男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender_add_input02" value="F">女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_add_select"></select>
                        </div>
                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button type="button" class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button type="button" class="btn btn-success" id="emp_del_all_modal_btn">删除</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-striped" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptname</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>


                </tbody>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6" id="page_info_area">

        </div>
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>
</div>
<script type="text/javascript">

    var totalRecord,currentPage;
    $(function () {
        to_page(1);
    });

    function to_page(pn){
        $.ajax({
            url:"${APP_Path}/emps",
            data:"pn="+pn,
            type:"GET",
            success:function(result){
                console.log(result);
                //1.解析并显示员工数据
                build_emp_table(result);
                //2.解析并显示分页信息
                build_page_info(result);
                //3.解析显示分页条数据
                build_page_nav(result);

            }
        });
    }

    function build_emp_table(result) {
        var emps = result.extend.pageInfo.list;
        $("#emps_table tbody").empty()
        $.each(emps,function (index,item) {
            var checkBoxTD=$("<td><input type='checkbox' class='check_item'/></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender==='M'?"男":"女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTD=$("<td></td>").append(item.department.deptName);
            var editBtn = $("<button></button>").addClass("btn btn-info btn-sm edit_btn").append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            editBtn.attr("edit-id",item.empId);
            var delbtn = $("<button></button>").addClass("btn btn-success btn-sm del_btn").append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            delbtn.attr("del-id",item.empId);
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delbtn);
            $("<tr></tr>").append(checkBoxTD).append(empIdTd).append(empNameTd).append(genderTd).append(emailTd).append(deptNameTD).append(btnTd).appendTo("#emps_table tbody");
        })
    }

    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append("当前第 "+result.extend.pageInfo.pageNum+" 页，总 "+result.extend.pageInfo.pages+" 页，共 "+result.extend.pageInfo.total+" 条记录")

        totalRecord=result.extend.pageInfo.pages;
        currentPage=result.extend.pageInfo.pageNum;
    }

    function build_page_nav(result) {
        $("#page_nav_area").empty();
        var ul=$("<ul></ul>").addClass("pagination");

        var firsPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));
        if(result.extend.pageInfo.hasPreviousPage==false){
             firsPageLi.addClass("disabled");
             prePageLi.addClass("disabled");
        }else{
            firsPageLi.click(function(){
                to_page(1);
            });
            prePageLi.click(function(){
                to_page(result.extend.pageInfo.pageNum-1);
            });
         }

        var nexPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi=$("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
        if(result.extend.pageInfo.hasNextPage==false){
             nexPageLi.addClass("disabled");
             lastPageLi.addClass("disabled");
        }else{
            nexPageLi.click(function(){
                to_page(result.extend.pageInfo.pageNum+1);
            });
            lastPageLi.click(function(){
                to_page(result.extend.pageInfo.pages);
            });
        }

        ul.append(firsPageLi).append(prePageLi);
        $.each(result.extend.pageInfo.navigatepageNums,function(index,item){
            var numLi=$("<li></li>").append($("<a></a>").append(item));
            //判断
            if(result.extend.pageInfo.pageNum==item ){
                 numLi.addClass("active");
             }
            numLi.click(function(){
                to_page(item);
            });
             ul.append(numLi);
        });
        ul.append(nexPageLi).append(lastPageLi);
        var navELe=$("<nav></nav>").append(ul);  //把ul加入到nav中去
        //$("#page_nav_area").append(nav);
        navELe.appendTo("#page_nav_area");
    }

    $('#emp_add_modal_btn').click(function () {
        getDepts("#empAddModal select");
        $('#empAddModal').modal({
                     backdrop:"static"
                 })
    });

    $("#check_all").click(function(){
        //attr是获取自定义属性的值$(this).attr("checked");
        //prop是修改和读取dom原始属性的值
        //alert($(this).prop("checked"));   $(this).prop("checked") 返回值为true和false
        $(".check_item").prop("checked",$(this).prop("checked"));
    });

    $('#emp_update_btn').click(function () {

        var email=$("#email_update_input").val();
        var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            //alert("邮箱格式不正确!!!");
            show_validate_msg("#email_update_input","error","邮箱格式不正确!!!");
            return false;
        }else{
            show_validate_msg("#email_update_input","success","");
        }

        //alert($("#empUpdateModal form").serialize());
        $.ajax({
            url:"${APP_Path}/emp/"+$(this).attr("edit-id"),
            type:"POST",
            data:$("#empUpdateModal form").serialize()+"&_method=PUT",
            success:function () {
                $("#empUpdateModal").modal("hide");
                to_page(currentPage);
            }

        })

    });

    $("#emp_del_all_modal_btn").click(function(){
        var empNames="";
        var del_ids="";
        $.each($(".check_item:checked"),function(){   //遍历已经选中的元素
            empNames+=$(this).parents("tr").find("td:eq(2)").text()+",";//找到父元素的tr里面的索引为2的td
            //组装员工ids
            del_ids+=$(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        empNames = empNames.substring(0,empNames.length-1);
        del_ids.substring(0,del_ids.length-1);
        if(confirm("确认删除【"+empNames+"】吗？")){
            //发送ajax请求
            //alert(1);
            $.ajax({
                url:"${APP_Path}/emp/"+del_ids,
                type:"DELETE",
                success:function(result){
                    alert(result.msg);
                    //回到当前页面
                    to_page(currentPage);
                }
            });
        }
    });

    function show_validate_msg(element,status_info,msg){
        //清除当前元素的校验状态
        $(element).parent().removeClass("has-success has-error");
        $(element).next("span").text("");
        if("success"==status_info){
            $(element).parent().addClass("has-success");
            $(element).next("span").text(msg);
        }else if("error"==status_info){
            $(element).parent().addClass("has-error");
            $(element).next("span").text(msg);
        }
    }

    $("#empName_add_input").change(function(){
        //发送ajax请求校验用户名是否可用
        var empName=this.value;
        $.ajax({
            url:"${APP_Path}/checkuser",
            data:"empName="+empName,
            type:"POST",
            success:function(result){
                if(result.code==100){
                    show_validate_msg("#empName_add_input","success","用户名可用!");
                    $('#emp_save_btn').attr("ajax-va","success");//添加一个校验标记    判断是否真的可以保存  禁用保存按钮
                }else{
                    show_validate_msg("#empName_add_input","error",result.extend.va_msg);
                    $('#emp_save_btn').attr("ajax-va","error");
                }
            }
        });
    });


    $('#emp_save_btn').click(function(){
        //1.模态框中填写的表单数据提交给服务器保存
        //保存前先对员工信息进行校验

        //用后端来校验  更加安全    使用前后端一起校验  安全性！！！！！！
        // if(!validate_add_form()){
        //     return false;
        // }
        //
        //
        // //1.判断之前Ajax校验用户名是否正确
        if($(this).attr("ajax-va")=="error"){
            return false;
        }
        //alert($("#empAddModal form").serialize());
        //2.发送Ajax请求保存员工
        $.ajax({
            url:"${APP_Path}/emps",
            type:"POST",
            data:$("#empAddModal form").serialize(),
            success:function(result){
                console.log(result);
                if(result.code===100){
                    //alert(result.msg);
                    //员工保存成功后 1.关闭模态框  2.到最后一页显示数据 (发送ajax请求显示最后一页数据即可)
                    $("#empAddModal").modal('hide');
                    to_page(totalRecord);	  //取得很大的一个数   使得分页到最后一页
                }else{
                    //显示失败信息
                    console.log(result);
                    if(undefined!==result.extend.errorFields.email){
                        //显示邮箱错误信息
                        show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
                    }
                    if(undefined!==result.extend.errorFields.empName){
                        //显示用户名错误信息
                        show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
                    }
                }
            }
        });
    });

    function getDepts(ele){
        //清空之前下拉列表的数据
        $(ele).empty();
        $.ajax({
            url:"${APP_Path}/depts",
            type:"GET",
            success:function(result){
                console.log(result);//[{deptId: 1, deptName: "开发部"}, {deptId: 2, deptName: "人事部"}, {deptId: 3, deptName: "开发部02"},…]

                $.each(result.extend.depts,function(){//遍历
                    var optionEle=$("<option></option>").append(this.deptName).attr("value",this.deptId);
                    optionEle.appendTo(ele);
                });
            }
        });
    }

    function getEmp(id){
        $.ajax({
            url:"${APP_Path}/emp/"+id,
            type:"GET",
            success:function(result){
                var emp=result.extend.emp;
                $("#empName_update_static").text(emp.empName);
                $("#email_update_input").val(emp.email);
                $("#empUpdateModal input[name=gender]").val([emp.gender]);
                $("#empUpdateModal select").val([emp.dId]);

            }
        });
    }

    /* $(".edit_btn").click(function(){
        alert("edit");
    }); */
    $(document).on("click",".edit_btn",function(){
        //alert("edit");
        //1.查出部门信息，显示部门列表
        getDepts("#empUpdateModal select");
        //2.查出员工信息，显示员工信息
        getEmp($(this).attr("edit-id"));
        // //3.将员工id传递到模态框的更新按钮里面
        $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
        $("#empUpdateModal").modal({
            backdrop:"static"
        });
    });

    $(document).on("click",".del_btn",function () {
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        var empId = $(this).attr("del-id");
        //alert($(this).parents("tr").find("td:eq(1)").text());
        if(confirm("确认删除【"+empName+"】吗？")){
            //发送ajax请求
            //alert(1);
            $.ajax({
                url:"${APP_Path}/emp/"+empId,
                type:"DELETE",
                success:function(result){
                    alert(result.msg);
                    //回到当前页面
                    to_page(currentPage);
                }
            });
        }
    })

</script>
</body>
</html>
