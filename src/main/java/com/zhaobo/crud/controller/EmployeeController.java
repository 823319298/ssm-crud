package com.zhaobo.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zhaobo.crud.bean.Employee;
import com.zhaobo.crud.bean.Msg;
import com.zhaobo.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.jar.Attributes;

@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;


    @RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id")Integer id) {
        Employee employee =employeeService.getEmp(id);
        return Msg.success().add("emp", employee);
    }

    @RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
    @ResponseBody
    public Msg updateEmp(Employee employee) {

        System.out.println(employee.getEmpId());
        System.out.println(employee.getEmpName());
        System.out.println(employee.getGender());
        System.out.println(employee.getEmail());
        System.out.println(employee.getdId());
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    @RequestMapping(value = "/emps" , method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(Employee employee){
        employeeService.saveEmp(employee);
        return Msg.success();
    }

    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Model model){
        PageHelper.startPage(pn,5);
        PageHelper.orderBy("emp_id asc");
        List<Employee> emps = employeeService.getAll();
        PageInfo page = new PageInfo(emps,5);
        return Msg.success().add("pageInfo",page);
    }

    @ResponseBody
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    public Msg deleteEmpById(@PathVariable("ids")String ids)
    {
        if (ids.contains("-")){
            List<Integer> del_ids = new ArrayList<>();
            String[] str_ids = ids.split("-");
            for (String string : str_ids){
                del_ids.add(Integer.parseInt(string));
            }
            employeeService.deleteBatch(del_ids);
        }
        else {
            Integer id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }
        return Msg.success();
    }


    @ResponseBody
    @RequestMapping("/checkuser")
    public Msg checkUser(@RequestParam("empName")String empName) {
        //先判断用户名是否是合法的表达式
        String regempName="(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if(!empName.matches(regempName)) {
            return Msg.fail().add("va_msg", "用户名可以是2-5位中文或者6-16位英文和数字或者下划线的组合!!!");
        }

        //数据库用户名重复验证
        boolean b=employeeService.checkUser(empName);
        if(b) {
            return Msg.success();  //100
        }else {
            return Msg.fail().add("va_msg", "用户名不可用!!!");
        }

    }


    //@RequestMapping("/emps")
    public String getEmp(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Model model){

        PageHelper.startPage(pn,5);
        List<Employee> emps = employeeService.getAll();
        PageInfo page = new PageInfo(emps,5);
        model.addAttribute("pageInfo", page);

        return "list";
    }

}
