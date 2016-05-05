package com.gonghui.pay.code.generator.rapid;

import com.gonghui.pay.code.generator.rapid.model.DBConfig;
import org.junit.Test;

import java.io.File;
import java.util.Map;
import java.util.Properties;

import static org.junit.Assert.*;

/**
 * Created by Administrator on 2015/11/8.
 */
public class RapidGeneratorTest {

    /**
     * Oracle需自行添加jdbc  因为oracal没有授权给maven
     * @throws Exception
     */

    public void testGeneratorOneTable() throws Exception {
        RapidGenerator rapidGenerator = new RapidGenerator();
        rapidGenerator.setAuthor("査锦星");

        DBConfig dbConfig = new DBConfig();
        dbConfig.setUrl("jdbc:mysql://127.0.0.1:3306/test?useUnicode=true&amp;characterEncoding=UTF-8");
        dbConfig.setUserName("root");
        dbConfig.setPwd("123456");
        dbConfig.setDriver("com.mysql.jdbc.Driver");

        rapidGenerator.initDbConfig(dbConfig);
        //输出路径
        rapidGenerator.initOutRootPathConfig("/Users/JensenZz/Documents/jiedaibao/umg/trunk/umg-dao");
        rapidGenerator.initOutRootPathConfig("/Users/JensenZz/Documents/log");
        //项目名
        rapidGenerator.initPackage("com.jiedaibao.umg.dao");
        //模块名  可随意
        rapidGenerator.initModelName("user");
        //表名
        rapidGenerator.generatorOneTable("UMG_BANK");
        rapidGenerator.generatorOneTable("UMG_USR_BCARD");

    }

    public static void main(String[] args) throws Exception {
        RapidGeneratorTest rapidGeneratorTest=new RapidGeneratorTest();
        rapidGeneratorTest.testGeneratorOneTable();
    }
}