package com.pgy.web.configuration;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;


@Configuration
@ConfigurationProperties
public class RedisConfiguration {
	
    @Value("${redis.config.host}")	
	private String host;
    
    @Value("${redis.config.port}")
	private int port;
    
    @Value("${redis.config.timeout}")
    private int timeout;
    
    @Value("${redis.config.password}")
    private String password;
    
    @Value("${redis.config.maxWaitMillis}")
    private Integer maxWaitMillis;
    
	@Bean
	public JedisPool getJedis(JedisPoolConfig jedisPoolConfig) {			     	        
		return new JedisPool(jedisPoolConfig,host,port,timeout,password);
	}
	
	@Bean
	public JedisPoolConfig getJedisPoolConfig() { 
		JedisPoolConfig jedisPoolConfig = new JedisPoolConfig(); 
		jedisPoolConfig.setMaxWaitMillis(maxWaitMillis);
		jedisPoolConfig.setTestOnBorrow(true);
		return jedisPoolConfig;
	}
}
