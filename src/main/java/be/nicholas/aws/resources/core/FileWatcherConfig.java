package be.nicholas.aws.resources.core;

import jakarta.annotation.PreDestroy;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.devtools.filewatch.FileSystemWatcher;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.io.File;
import java.time.Duration;

@Slf4j
@Configuration
public class FileWatcherConfig {

    @Bean
    public FileSystemWatcher fileSystemWatcher() {
        FileSystemWatcher fileSystemWatcher = new FileSystemWatcher(true, Duration.ofMillis(5000L), Duration.ofMillis(3000L));
        fileSystemWatcher.addSourceDirectory(new File("/root/.aws"));
        fileSystemWatcher.addListener(new MyFileChangeListener());
        fileSystemWatcher.start();
        log.info("started file system watcher");
        return fileSystemWatcher;
    }

    @PreDestroy
    public void onDestroy() {
        fileSystemWatcher().stop();
    }
}