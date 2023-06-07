package com.example.demo.config;


import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.autoconfigure.jdbc.DataSourceBuilder;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
@EnableTransactionManagement
@MapperScan(basePackages = "com.example.demo.*",annotationClass = Repository.class)
public class MybatisConfiguration {

    @Bean("sampleDataSource")
    @ConfigurationProperties(prefix = "spring.datasource.dbcp2")
    public DataSource getSqlServerDataSource(){
        return DataSourceBuilder.create().build();
    }

    @Primary
    @Bean("sqlServerSessionFactory")
    public SqlSessionFactory getSqlSessionFactoryBean(@Qualifier("sampleDataSource") DataSource dataSource) throws Exception {
        SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
        sqlSessionFactoryBean.setDataSource(dataSource);
        PathMatchingResourcePatternResolver patternResolver = new PathMatchingResourcePatternResolver();
        sqlSessionFactoryBean.setMapperLocations(patternResolver.getResources("classpath:mapper/*.xml"));

        return (SqlSessionFactory)sqlSessionFactoryBean.getObject();
    }

    @Primary
    @Bean
    public SqlSessionTemplate getSqlSessionFaSessionTemplate(SqlSessionFactory sqlSessionFactory){
        SqlSessionTemplate sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory);
        return sqlSessionTemplate;
    }
}
