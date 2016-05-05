<#assign className=table.className/>
<#assign classNameLower = table.classNameFirstLower/>
${gg.setOverride(false)}<#t/>
${gg.setOutputFile(javaPath+separator+"dao"+separator+pageModuleName+separator+className+"Mapper.java")}<#t/>
package ${javaPackage}.dao.${pageModuleName};

/**
* @ClassName: ${className}Mapper
* @Description:
* @author ${author}
* @date ${createTime}
*/
public interface ${className}Mapper extends BaseMapper<${className}>{
	
}