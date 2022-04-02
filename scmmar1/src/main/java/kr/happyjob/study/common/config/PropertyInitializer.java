package kr.happyjob.study.common.config;


import org.springframework.context.ApplicationContextInitializer;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.core.env.PropertySource;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.support.ResourcePropertySource;

public class PropertyInitializer implements ApplicationContextInitializer<ConfigurableApplicationContext> {

	@Override
	public void initialize(ConfigurableApplicationContext ctx) {
		try{
			 PropertySource ps =new ResourcePropertySource(new ClassPathResource("happyjob.properties"));
			ctx.getEnvironment().getPropertySources().addFirst(ps);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		
		
	}
	
	
	

}
