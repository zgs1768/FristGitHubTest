package com.atguigu.scw.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

//分发请求的controller  跳转首页/错误提示页面

@Controller
public class DispatcherController {

//    提供多个跳转到首页得路径
    @RequestMapping(value = {"/","/index","/index.html"})
    public String index(){
        return "index";
    }

    @RequestMapping(value = {"/login.html"})
    public String toLoginPage(){
        return "login";
    }


}
