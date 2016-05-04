<#assign className=table.className/>
<#assign classNameLower = table.classNameFirstLower/>
${gg.setOverride(true)}<#t/>
${gg.setOutputFile(javaPath+separator+"model"+separator+pageModuleName+separator+className+".java")}<#t/>
/**
*@Author: ${author}
*@Date: ${createTime}
*/
package ${javaPackage}.model.${pageModuleName};

/**
* @ClassName: ${className}
* @Description:${(table.remarks)!}
* @author ${author}
* @date ${createTime}
*/
public class ${className}{
	
	<#list table.columns as column>
	<#if column.remarks??>
	//${column.remarks}
	</#if>
	private ${column.simpleJavaType} ${column.columnNameLower};
	</#list>

<@generateJavaColumns/>
}

<#macro generateJavaColumns>
	<#list table.columns as column>

	public void set${column.columnName}(${column.simpleJavaType} value) {
		this.${column.columnNameLower} = value;
	}
	public ${column.simpleJavaType} get${column.columnName}() {
		return this.${column.columnNameLower};
	}
	</#list>
</#macro>


