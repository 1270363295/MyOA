package org.java.web;

import org.activiti.engine.ProcessEngine;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.Model;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.repository.ProcessDefinitionQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author ：温戴
 * @date ：Created in 2019/9/24 9:42
 * @description：流程的配置
 */
@Controller
public class ProcessController {

    @Autowired
    private RepositoryService repositoryService;

    //部署流程定义
    @RequestMapping("deploy")
    public String deploy(@RequestParam("bpmn") MultipartFile bpmn, @RequestParam("png") MultipartFile png) throws IOException {
        //得到文件名
        String bpmnName = bpmn.getOriginalFilename();
        String pngName = png.getOriginalFilename();

        //得到文件对应的输入流
        InputStream bpmnIn = bpmn.getInputStream();
        InputStream pngIn = png.getInputStream();

        //部署流程定义
        repositoryService.createDeployment().addInputStream(bpmnName, bpmnIn).addInputStream(pngName, pngIn).deploy();
        //返回查询流程
        return "";
    }

    //查询流程定义
    @RequestMapping("selectProcessDefinition")
    @ResponseBody
    public Map selectProcessDefinition() {
        ProcessDefinitionQuery query = repositoryService.createProcessDefinitionQuery();
        List<ProcessDefinition> list = query.list();

        Map map = new HashMap();
        map.put("code", 0);
        map.put("msg", "");
        map.put("count", list.size());
        map.put("data", list);
        return map;
    }
}
