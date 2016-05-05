<#assign className=table.className/>
<#assign classNameLower = table.classNameFirstLower/>
<#macro mapperEl value type>${r"#{"}${value},jdbcType=${type}}</#macro>
<#macro mapperElVa value>${r"#{"}${value}}</#macro>
<#macro mapperElPr value>${r"${"}${value}}</#macro>
${gg.setOverride(true)}<#t/>
${gg.setOutputFile(mybatisXMLPath+separator+pageModuleName+separator+className+"Mapper.xml")}<#t/>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${javaPackage}.mapper.${pageModuleName}.${className}Mapper">
    <resultMap id="fieldMapper" type="${javaPackage}.domain.${pageModuleName}.${className}">
	<#list table.pkColumns as pk>
		<id property="${pk.columnNameFirstLower}" column="${(pk.sqlName)?upper_case}" /><!--${(pk.remarks)!''}-->
	</#list>
	<#list table.notPkColumns as column>
        <result property="${column.columnNameFirstLower}" column="${column.sqlName?upper_case}" /><!--${(column.remarks!'')}-->
	</#list>
    </resultMap>
    <sql id="field">
		<@field></@field>
    </sql>
    <sql id="property">
		<@property></@property>
    </sql>
    <sql id="fieldAsProperty">
		<@fieldAsProperty></@fieldAsProperty>
    </sql>

    <sql id="fieldEqProperty">
		<@fieldEqProperty></@fieldEqProperty>
    </sql>
    <sql id="fieldEqPropertyIf">
		<@fieldEqPropertyIf></@fieldEqPropertyIf>
    </sql>

    <sql id="idCnd">
        <where>
			<@idCndNotNull table.pkColumns />
        </where>
    </sql>

    <insert id="save" parameterType="${classNameLower}">
        INSERT INTO ${table.sqlName} (<include refid="field"/>) VALUES (<include refid="property"/>)
    </insert>

    <delete id="deleteById" parameterType="${classNameLower}" >
        DELETE FROM  ${table.sqlName} <include refid="idCnd" />
    </delete>

    <select id="selectById" resultType="${classNameLower}" parameterType="${classNameLower}">
        SELECT<include refid="fieldAsProperty" />FROM ${table.sqlName}<include refid="idCnd" />
    </select>

    <update id="updateByIdSelective" parameterType="${classNameLower}">
        UPDATE ${table.sqlName}<set><include refid="fieldEqPropertyIf" /></set><include refid="idCnd" />
    </update>

    <update id="updateById" parameterType="${classNameLower}">
        UPDATE ${table.sqlName}<set><include refid="fieldEqProperty" /></set><include refid="idCnd" />
    </update>
</mapper>

<#macro idCnd pkColumns>
	<#compress>
		<#if pkColumns?? >
			<#if pkColumns?size==1 >
			${pkColumns?first.columnNameFirstLower}==null
			<#else >
				<#assign  index = 0 />
				<#list pkColumns as pk>
					<#if index == 0>
						<#assign  index = index+1/>
					${pk.columnNameFirstLower}==null
					<#else >
                    and  ${pk.columnNameFirstLower}
					</#if>
				</#list>
			</#if>
		</#if>
	</#compress>
</#macro>

<#macro idCndNotNull pkColumns>
	<#if pkColumns?? >
		<#if pkColumns?size==0>
			1!=1
		</#if>
		<#if pkColumns?size==1 >
			<#assign  pk = pkColumns?first />
        <if test="${pk.columnNameFirstLower}!=null" >${pk.sqlName?upper_case}=<@mapperEl pk.columnNameFirstLower pk.jdbcSqlTypeName/></if>
        <if test="${pk.columnNameFirstLower}==null" >AND 1=0</if>
		<#else >
			<#assign  index = 0 />
			<#list pkColumns as pk>
				<#if index == 0>
					<#assign  index = index+1/>
                <if test="${pk.columnNameFirstLower}!=null" >${column.sqlName?upper_case}=<@mapperEl pk.columnNameFirstLower pk.jdbcSqlTypeName/></if>
                <if test="${pk.columnNameFirstLower}==null" >AND 1=0</if>
				<#else >
                <if test="${pk.columnNameFirstLower}!=null" >AND ${column.sqlName?upper_case}=<@mapperEl pk.columnNameFirstLower pk.jdbcSqlTypeName/></if>
                <if test="${pk.columnNameFirstLower}==null" >AND 1=0</if>
				</#if>
			</#list>
		</#if>
	</#if>
</#macro>


<#macro field>
	<#list table.columns as column>
	    ${column.sqlName?upper_case}<#if column_has_next>,</#if>
	</#list>
</#macro>
<#macro property>
	<#list table.columns as column>
		<@mapperEl column.columnNameFirstLower column.jdbcSqlTypeName/><#if column_has_next>,</#if>
	</#list>
</#macro>

<#macro fieldAsProperty>
	<#list table.columns as column>
		${column.sqlName?upper_case} AS ${column.columnNameFirstLower}<#if column_has_next>,</#if>
	</#list>
</#macro>
<#macro fieldEqProperty>
	<#list table.columns as column>
	    ${column.sqlName?upper_case}=<@mapperEl column.columnNameFirstLower column.jdbcSqlTypeName/><#if column_has_next>,</#if>
	</#list>
</#macro>
<#macro fieldEqProperty>
	<#list table.columns as column>
	    ${column.sqlName?upper_case}=<@mapperEl column.columnNameFirstLower column.jdbcSqlTypeName/><#if column_has_next>,</#if>
	</#list>
</#macro>
<#macro fieldEqPropertyIf>
	<#list table.columns as column>
        <if test="${column.columnNameFirstLower}!=null" >${column.sqlName?upper_case}=<@mapperEl column.columnNameFirstLower column.jdbcSqlTypeName/><#if column_has_next>,</#if></if>
	</#list>
</#macro>

<#macro pkColumns pkColumns>
	<#compress>
		<#if pkColumns??&&pkColumns?size==1>
		${pkColumns[0].columnNameFirstLower}
		</#if>
	</#compress>
</#macro>