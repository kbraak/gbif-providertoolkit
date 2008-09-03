package org.gbif.provider.upload;

import java.util.concurrent.CancellationException;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

import org.gbif.provider.model.UploadEvent;
import org.gbif.provider.util.AppConfig;
import org.gbif.provider.util.Constants;
import org.gbif.provider.util.ContextAwareTestBase;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

public class OccUploadTaskTest extends ContextAwareTestBase{
	@Autowired
	@Qualifier("occUploadTask")
	private Task<UploadEvent> occUploadTask;
	@Autowired
	private AppConfig cfg;
	
	@Test
	public void testUploadTask() {
		boolean result = false;
		occUploadTask.init(Constants.TEST_RESOURCE_ID, Constants.TEST_USER_ID);
		
		ExecutorService executor = Executors.newSingleThreadExecutor();
		Future<UploadEvent> f = executor.submit(occUploadTask);
		try {
//			Thread.sleep(5000);
//			f.cancel(true);
//			Thread.sleep(5000);
			UploadEvent event = f.get();
			System.out.println(event);
		} catch (CancellationException e) {
			result=true;
			e.printStackTrace();
		} catch (InterruptedException e) {
			e.printStackTrace();
		} catch (ExecutionException e) {
			e.printStackTrace();
		}
//		assertTrue(result);
	}
	
}
