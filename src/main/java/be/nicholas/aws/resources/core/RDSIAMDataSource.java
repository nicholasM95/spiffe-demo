package be.nicholas.aws.resources.core;

import com.zaxxer.hikari.HikariDataSource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.rds.RdsClient;
import software.amazon.awssdk.services.rds.RdsUtilities;
import software.amazon.awssdk.services.rds.model.GenerateAuthenticationTokenRequest;

import java.net.URI;

@Slf4j
public class RDSIAMDataSource extends HikariDataSource {

    @Value("${aws.region}")
    private String awsRegion;

    @Override
    public String getPassword() {
        // Alternatively, you can create a Bean declaration of RdsClient. For demo purposes, I have decided to instantiate it here.
        log.info("Get new db token");
        RdsClient rdsClient = RdsClient.builder()
                .region(Region.of(awsRegion))
                .build();

        RdsUtilities rdsUtilities = rdsClient.utilities();

        URI jdbcUri = parseJdbcURL(getJdbcUrl());

        GenerateAuthenticationTokenRequest request = GenerateAuthenticationTokenRequest.builder()
                .username(getUsername())
                .hostname(jdbcUri.getHost())
                .port(jdbcUri.getPort())
                .build();

        return rdsUtilities.generateAuthenticationToken(request);
    }

    private URI parseJdbcURL(String jdbcUrl) {
        String uri = jdbcUrl.substring(5);
        return URI.create(uri);
    }
}
