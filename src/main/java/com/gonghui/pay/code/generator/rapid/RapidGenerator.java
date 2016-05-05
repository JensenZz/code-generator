package com.gonghui.pay.code.generator.rapid;

import cn.org.rapid_framework.generator.GeneratorFacade;
import cn.org.rapid_framework.generator.GeneratorProperties;
import com.gonghui.pay.code.generator.rapid.model.DBConfig;

import java.io.File;
import java.util.Calendar;

public class RapidGenerator {
    //java源代码路径
    public static final String JAVA_PATH = "javaPath";
    //源代码mybatis配置路径
    public static final String MYBATIS_XML_PATH = "mybatisXMLPath";
    //创建者
    public static final String AUTHOR = "author";
    //创建时间
    public static final String CREATETIME = "createTime";

    protected GeneratorFacade g = new GeneratorFacade();

    public void generatorOneTable(String tableName)
            throws Exception {
        g.generateByTable(tableName);
    }


    public void initDbConfig(DBConfig dbConfig) {
        //配置相关属性
        GeneratorProperties.setProperty("jdbc_username", dbConfig.getUserName());
        GeneratorProperties.setProperty("jdbc_password", dbConfig.getPwd());
        GeneratorProperties.setProperty("jdbc_url", dbConfig.getUrl());
        GeneratorProperties.setProperty("jdbc_driver", dbConfig.getDriver());
        initDateType();
    }

    protected void initDateType() {
        //处理数据库类型
        GeneratorProperties.setProperty("java_typemapping.java.sql.Timestamp", "java.util.Date");
        GeneratorProperties.setProperty("java_typemapping.java.sql.Date", "java.util.Date");
        GeneratorProperties.setProperty("java_typemapping.java.sql.Time", "java.util.Date");
        GeneratorProperties.setProperty("java_typemapping.java.lang.Byte", "java.lang.Integer");
        //处理数其他类型

    }

    public void initPackage(String javaPackage) {
        String XmlPath = javaPackage.replaceAll("\\.dao", "");
        if (System.getProperty("os.name").equals("Mac OS X")) {
            String XmlPath1=XmlPath.replaceAll("\\.","/");
            String packPath = javaPackage.replaceAll("\\.", "/");
            String reallyPath = "src/main/java/" + packPath;
            GeneratorProperties.setProperty(RapidGenerator.JAVA_PATH, reallyPath);
            GeneratorProperties.setProperty("javaPackage", javaPackage);
            String myBatis = "src/main/resources/" + XmlPath1 + "/mappers";
            GeneratorProperties.setProperty(RapidGenerator.MYBATIS_XML_PATH, myBatis);
        } else {
            String packPath = javaPackage.replaceAll("\\.", "\\\\");
            String XmlPath1=XmlPath.replaceAll("\\.","\\\\");
            String reallyPath = "\\src\\main\\java\\" + packPath;
            GeneratorProperties.setProperty(RapidGenerator.JAVA_PATH, reallyPath);
            GeneratorProperties.setProperty("javaPackage", javaPackage);
            String myBatis = "\\src\\main\\resources\\" + XmlPath1 + "\\mappers";
            GeneratorProperties.setProperty(RapidGenerator.MYBATIS_XML_PATH, myBatis);
        }
    }

    public void initModelName(String modelName) {
        GeneratorProperties.setProperty("separator", File.separator);
        GeneratorProperties.setProperty("pageModuleName", modelName);
    }

    public void initOutRootPathConfig(String outRootDir) {
        g.getGenerator();
        g.getGenerator().setOutRootDir(outRootDir);
        String path = getClass().getClassLoader().getResource("template").getFile().replaceFirst("/", "");
        if (System.getProperty("os.name").equals("Mac OS X")) {
            g.getGenerator().addTemplateRootDir("target/classes/template");
        } else {
            g.getGenerator().addTemplateRootDir(path);
        }
    }

    public void setAuthor(String author) {
        GeneratorProperties.setProperty(RapidGenerator.AUTHOR, author);
        GeneratorProperties.setProperty(
                RapidGenerator.CREATETIME, RapidGenerator
                        .getCreateTime());
    }

    private static String getCreateTime() {
        Calendar now = Calendar.getInstance();
        return now.get(Calendar.YEAR) + "-" + (now.get(Calendar.MONTH) + 1) + "-" + now.get(Calendar.DAY_OF_MONTH);
    }

}
