package ${package}.bean;

import com.jsmartframework.web.adapter.ListAdapter;
import com.jsmartframework.web.annotation.PreSubmit;
import com.jsmartframework.web.annotation.QueryParam;
import com.jsmartframework.web.util.WebText;
import com.jsmartframework.web.manager.WebContext;
import com.jsmartframework.web.annotation.WebBean;

import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.servlet.http.Cookie;

import ${package}.adapter.Adapter;
import ${package}.service.SpringService;

@WebBean
public class HomeBean {

    @Autowired
    private SpringService springService;

    private String sessionId;

    private String name;

    private int age;

    @PostConstruct
    public void init() {
        sessionId = getSessionId();
    }

    private String getSessionId() {
        Cookie[] cookies = WebContext.getRequest().getCookies();
        for (Cookie cookie : cookies) {
            if ("JSESSIONID".equals(cookie.getName())) {
                return cookie.getValue();
            }
        }
        return null;
    }

    public void addContent() {
        Adapter adapter = new Adapter();
        adapter.setName(name);
        adapter.setAge(age);
        springService.putAdapter(sessionId, adapter);
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public MyListAdapter getMyListAdapter() {
        return new MyListAdapter();
    }

    private class MyListAdapter extends ListAdapter<Adapter> {

        @Override
        public List<Adapter> load(final int offsetIndex, final Object offset, final int size) {

            List<Adapter> list = springService.getAdapters(sessionId);

            if (offsetIndex + size <= list.size()) {
                return list.subList(offsetIndex, offsetIndex + size);
            } else {
                return list.subList(offsetIndex, list.size());
            }
        }
    }
}

