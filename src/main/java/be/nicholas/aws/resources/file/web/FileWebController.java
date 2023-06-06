package be.nicholas.aws.resources.file.web;

import be.nicholas.aws.resources.file.service.FileService;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;

@RestController
@RequestMapping("/file")
public class FileWebController {
    private final FileService fileService;

    public FileWebController(FileService fileService) {
        this.fileService = fileService;
    }

    @GetMapping(path = "/{file}", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
    public void getFile(HttpServletResponse httpServletResponse, @PathVariable("file") String file) throws IOException {
        IOUtils.copy(fileService.getFile(file), httpServletResponse.getOutputStream());
    }
}
