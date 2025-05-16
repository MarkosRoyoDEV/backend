package com.marcosroyo.backend.scheduler;

import com.marcosroyo.backend.service.TaskService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class DailyTaskScheduler {

    private static final Logger logger = LoggerFactory.getLogger(DailyTaskScheduler.class);

    @Autowired
    private TaskService taskService;

    /**
     * Resets all daily tasks to incomplete at midnight every day.
     * The cron expression "0 0 0 * * ?" means "at 00:00:00am every day".
     */
    @Scheduled(cron = "0 0 0 * * ?")
    public void resetDailyTasks() {
        logger.info("Running scheduled daily task reset");
        int resetCount = taskService.resetDailyTasks();
        logger.info("Reset {} daily tasks", resetCount);
    }
} 