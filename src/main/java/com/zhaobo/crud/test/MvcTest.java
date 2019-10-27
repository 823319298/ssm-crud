package com.zhaobo.crud.test;


import com.github.pagehelper.PageInfo;
import com.zhaobo.crud.bean.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.Request;
import org.junit.runner.Result;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import javax.naming.Context;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml","file:C:\\programmer\\workspace\\ssm-crud\\src\\main\\webapp\\WEB-INF\\dispatcherServlet-servlet.xml"})
public class MvcTest {

    @Autowired
    WebApplicationContext context;
    MockMvc mockMvc;

    @Before
    public void  initMockMvc(){

        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception{
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn","5")).andReturn();

        MockHttpServletRequest request = result.getRequest();
        PageInfo attribute = (PageInfo) request.getAttribute("pageInfo");

        System.out.println("当前页码，"+attribute.getPageNum());
        System.out.println("总页码，"+attribute.getPages());
        System.out.println("总记录数，"+attribute.getTotal());
        System.out.println("在页面需要连续显示的页码，");
        int[] nums = attribute.getNavigatepageNums();
        for(int i : nums){
            System.out.println(" "+i);
        }
        List<Employee> list = attribute.getList();
        for (Employee employee : list){
            System.out.println("ID, "+employee.getEmpId()+"==>Name:"+employee.getEmpName());
        }
    }
}
