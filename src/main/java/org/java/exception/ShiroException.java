package org.java.exception;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author ：温戴
 * @date ：Created in 2019/9/20 15:41
 * @description：
 */
@Component
public class ShiroException implements HandlerExceptionResolver {
    @Override
    public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {

        //得到异常的原因
        String msg = ex.getMessage();

        //产生ModelAndView
        //
        ModelAndView mv = new ModelAndView("/login");
        mv.addObject("msg",msg );

        return mv;
    }
}
