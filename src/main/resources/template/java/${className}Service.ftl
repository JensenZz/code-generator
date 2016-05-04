<#assign className=table.className/>
<#assign classNameLower = table.classNameFirstLower/>
${gg.setOverride(false)}<#t/>
${gg.setOutputFile(javaPath+separator+"service"+separator+pageModuleName+separator+className+"Service.java")}<#t/>
package ${javaPackage}.service.${pageModuleName};
import org.springframework.stereotype.Service;

/**
* @ClassName: ${className}Service
* @Description:
* @author ${author}
* @date ${createTime}
*/
@Service
public class ${className}Service{
	
}