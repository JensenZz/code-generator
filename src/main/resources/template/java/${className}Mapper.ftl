<#assign className=table.className/>
<#assign classNameLower = table.classNameFirstLower/>
${gg.setOverride(false)}<#t/>
${gg.setOutputFile(javaPath+separator+"mapper"+separator+pageModuleName+separator+className+"Mapper.java")}<#t/>
package ${javaPackage}.mapper.${pageModuleName};

import ${javaPackage}.domain.${pageModuleName}.${className};

/**
* @ClassName: ${className}Mapper
* @Description:
* @author ${author}
* @date ${createTime}
*/
public interface ${className}Mapper{

     public int save (${className}  ${classNameLower});

     public ${className} selectById (${className}  ${classNameLower});

     public int updateByIdSelective(${className} ${classNameLower});

     public int updateById(${className} ${classNameLower});

     public int deleteById(${className} ${classNameLower});

}