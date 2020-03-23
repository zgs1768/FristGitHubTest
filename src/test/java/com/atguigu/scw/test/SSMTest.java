package com.atguigu.scw.test;

import com.atguigu.scw.bean.TAdmin;
import com.atguigu.scw.mapper.TAdminMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@ContextConfiguration(locations = {"classpath:spring/spring-bean.xml",
        "classpath:spring/spring-mybatis.xml","classpath:spring/spring-tx.xml"})
@RunWith(value = SpringJUnit4ClassRunner.class)
public class SSMTest {
    //测试是否能够自动装配mapper对象.并调用方法
    @Autowired
    TAdminMapper adminMapper;

    @Test
    public void test(){
        long countByExample = adminMapper.countByExample(null);
        System.out.println("countByExample = " + countByExample);
    }

}
