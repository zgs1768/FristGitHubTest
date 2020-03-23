package com.atguigu.scw.Listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import javax.servlet.http.HttpSessionBindingEvent;

public class AppStartupListener implements ServletContextListener{

    //全局上下文创建后调用
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        //向域中存取上下文对象
        ServletContext application = sce.getServletContext();
        application.setAttribute("PATH", application.getContextPath());
//        System.out.println("contextInitialized 被调用了");
    }
    //`````````销毁前调用
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
//        System.out.println("contextDestroyed 被调用了");


    }
}
