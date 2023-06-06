package be.nicholas.aws.resources.file.service;

import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.lifecycle.Startables;
import org.testcontainers.utility.DockerImageName;

@SpringBootTest
public class FileServiceTest {

    static PostgreSQLContainer database = new PostgreSQLContainer(DockerImageName.parse("postgres:14.7"));

    @Autowired
    private FileService fileService;

    @DynamicPropertySource
    public static void setup(DynamicPropertyRegistry registry) {
        Startables.deepStart(database).join();

        registry.add("spring.datasource.url", database::getJdbcUrl);
        registry.add("spring.datasource.username", database::getUsername);
    }


    @Disabled
    @Test
    public void test() {
        fileService.getFile("");
    }
}
