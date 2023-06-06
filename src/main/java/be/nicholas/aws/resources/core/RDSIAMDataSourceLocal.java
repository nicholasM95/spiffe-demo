package be.nicholas.aws.resources.core;

import com.zaxxer.hikari.HikariDataSource;

public class RDSIAMDataSourceLocal extends HikariDataSource {

    @Override
    public String getPassword() {
        return "test";
    }
}
