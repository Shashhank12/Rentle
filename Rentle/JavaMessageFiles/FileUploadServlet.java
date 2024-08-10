import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.util.Collection;

@MultipartConfig
public class FileUploadServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");
        try {
            Collection<Part> parts = request.getParts();
            for (Part part : parts) {
                if (part.getSubmittedFileName() != null) {
                    String fileName = part.getSubmittedFileName();
                    String filePath = getServletContext().getRealPath("./images/") + fileName;
                    File uploadedFile = new File(filePath);

                    // Create directories if they do not exist
                    uploadedFile.getParentFile().mkdirs();

                    // Write file to the server
                    part.write(filePath);
                    
                    response.getWriter().println("File uploaded successfully: " + fileName + "<br>");
                    response.getWriter().println("File saved at: " + filePath + "<br>");
                }
            }
        } catch (Exception ex) {
            response.getWriter().println("File upload failed: " + ex.getMessage());
        }
    }
}
