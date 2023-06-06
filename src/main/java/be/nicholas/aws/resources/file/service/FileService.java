package be.nicholas.aws.resources.file.service;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.S3Object;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.InputStream;

@Service
public class FileService {

    @Value("${aws.bucket}")
    private String bucket;

    private final AmazonS3 s3Client;

    public FileService(AmazonS3 s3Client) {
        this.s3Client = s3Client;
    }

    public InputStream getFile(String file) {
        S3Object s3Object = s3Client.getObject(bucket, file);
        return s3Object.getObjectContent();
    }
}
