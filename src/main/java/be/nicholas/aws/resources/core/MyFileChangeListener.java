package be.nicholas.aws.resources.core;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.devtools.filewatch.ChangedFiles;
import org.springframework.boot.devtools.filewatch.FileChangeListener;
import org.springframework.stereotype.Component;
import java.util.Set;

@Slf4j
@Component
public class MyFileChangeListener implements FileChangeListener {

    @Override
    public void onChange(Set<ChangedFiles> changeSet) {
        changeSet.forEach(changedFile -> {
            changedFile.forEach(changedFile1 -> {
                log.info("{} --- {}", changedFile1.getFile().getAbsolutePath(), changedFile1.getType());
            });
        });
    }
}