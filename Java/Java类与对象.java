// 获取类声明的public属性列表
Field[] fields = this.getClass().getDeclaredFields();


// 编写注释类Annotation.class
import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.FIELD, ElementType.TYPE})
public @interface Annotation {
    String value() default "";
}
// 使用注解的方法给属性添加注释
@Annotation(value = "test")
// 获取属性值
String annotation = field.getAnnotation(Annotation.class).value();
