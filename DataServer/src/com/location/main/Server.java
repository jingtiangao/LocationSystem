package com.location.main;

import java.io.UnsupportedEncodingException;
import java.util.Iterator;

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import com.google.gson.*;
import com.location.dao.Impl.BaseDAO;
import com.location.entity.User_info;
import com.location.entity.User_info_History;
import com.location.json.JSON;

public class Server {

	public static final String user_id_list="http://tz.seekcy.com:8085/WebLocate/LocateResults?user_ids=1918E0000020,1918E0000021,1918E0000022&time_period=5000";
	
	public static void main(String[] args) {
		
		System.out.println("��ʼ�������ݡ�����");
		
		Runnable runnable=new Runnable() {
			@Override
			public void run() {
				// TODO Auto-generated method stub
				try {
					String json = JSON.getReturnData(user_id_list);
					System.out.println(json);
					
//					String json = "[{\"accuracy\":4.0,\"build_id\":\"26000\",\"error_code\":0,\"floor_id\":4,\"info\":\"\",\"nearest_tag_id\":\"0\",\"timestamp_millisecond\":1459137333190.0,\"user_id\":\"84EB185C9F5A\",\"x_millimeter\":44937,\"y_millimeter\":24413,\"compass\":300,\"alarm\":false},"
//							+ "{\"accuracy\":4.0,\"build_id\":\"26000\",\"error_code\":0,\"floor_id\":4,\"info\":\"\",\"nearest_tag_id\":\"0\",\"timestamp_millisecond\":1459137333190.0,\"user_id\":\"84EB185C9F5B\",\"x_millimeter\":44937,\"y_millimeter\":24413,\"compass\":300,\"alarm\":false}]";
					
					//����һ��Gson����
					Gson gson = new Gson();
					//����һ��JsonParser
					JsonParser parser = new JsonParser();
					//ͨ��JsonParser������԰�json��ʽ���ַ���������һ��JsonElement����
					JsonElement el = parser.parse(json);
					//
					JsonObject jObject = el.getAsJsonObject();
					
//					String jString = jObject.get("data").toString();
//					System.out.println(jString);
					JsonElement jElement = jObject.get("data");
					//��JsonElement����ת����JsonArray
					JsonArray jsonArray = null;
					
					if(jElement.isJsonArray()){
						System.out.println("yes");
						jsonArray = jElement.getAsJsonArray();
					}

					//����һ��BaseDao���������ݿ�д��POJO
					BaseDAO<User_info> baseDAO = new BaseDAO<>();
					BaseDAO<User_info_History> baseDAO2=new BaseDAO<>();
					
					//����JsonArray����
					User_info user_info = null;
					User_info_History user_info_History=null;
					System.out.println(jsonArray.toString());
					Iterator it = jsonArray.iterator();
					while(it.hasNext()){
						JsonElement jsonElement = (JsonElement) it.next();
						String str = jsonElement.getAsString();
						System.out.println(str);
						
						JsonElement e = parser.parse(str);
						
						//JsonElementת��ΪJavaBean����
						user_info = gson.fromJson(e, User_info.class);
						user_info_History=gson.fromJson(e, User_info_History.class);
//						System.out.println(user_info.getUser_id()+' '+user_info.getTimestamp_millisecond());
						baseDAO.update(user_info);
						baseDAO2.create(user_info_History);
						System.out.println(user_info_History.getUser_id()+" ======== "+user_info_History.getTimestamp_millisecond());
						System.out.println(user_info.getUser_id()+" === "+user_info.getTimestamp_millisecond());
					}
					
				} catch (UnsupportedEncodingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		};
		ScheduledExecutorService service = Executors.newSingleThreadScheduledExecutor();
		// �ڶ�������Ϊ�״�ִ�е���ʱʱ�䣬����������Ϊ��ʱִ�еļ��ʱ��  
        service.scheduleAtFixedRate(runnable, 1, 3, TimeUnit.SECONDS);
		
	}
}
