package com.zhaobo.crud.controller;


import com.zhaobo.crud.bean.Department;
import com.zhaobo.crud.bean.Msg;
import com.zhaobo.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    @RequestMapping(value = "/depts" , method = RequestMethod.GET)
    @ResponseBody
    public Msg getDepts(){

        List<Department> list = departmentService.getDepts();
        return Msg.success().add("depts",list);
    }

}
