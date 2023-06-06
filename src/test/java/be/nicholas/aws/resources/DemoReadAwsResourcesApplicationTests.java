package be.nicholas.aws.resources;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.lifecycle.Startables;
import org.testcontainers.utility.DockerImageName;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
class DemoReadAwsResourcesApplicationTests {

    static PostgreSQLContainer database = new PostgreSQLContainer(DockerImageName.parse("postgres:14.7"));

    @DynamicPropertySource
    public static void setup(DynamicPropertyRegistry registry) {
        Startables.deepStart(database).join();

        registry.add("spring.datasource.url", database::getJdbcUrl);
        registry.add("spring.datasource.username", database::getUsername);
    }



    @Test
    void contextLoads() {
    }

}
