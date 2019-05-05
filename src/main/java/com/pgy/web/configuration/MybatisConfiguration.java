package com.pgy.web.configuration;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Configuration;

@Configuration
@MapperScan("com.pgy.web.dao")
public class MybatisConfiguration {

}
