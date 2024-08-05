<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>

<%
if (ServletFileUpload.isMultipartContent(request)) {
    try {
        DiskFileItemFactory factory = new DiskFileItemFactory();
        File repository = (File) getServletContext().getAttribute("javax.servlet.context.tempdir");
        factory.setRepository(repository);

        ServletFileUpload upload = new ServletFileUpload(factory);
        List<FileItem> items = upload.parseRequest(request);

        Iterator<FileItem> iter = items.iterator();
        while (iter.hasNext()) {
            FileItem item = iter.next();

            if (!item.isFormField()) {
                String fileName = new File(item.getName()).getName();
                String filePath = getServletContext().getRealPath("./Rental/Images/") + fileName;
                File uploadedFile = new File(filePath);

                item.write(uploadedFile);
                out.println("File uploaded successfully: " + fileName + "<br>");
                out.println("File saved at: " + filePath + "<br>");
            }
        }
    } catch (Exception ex) {
        out.println("File upload failed: " + ex.getMessage());
    }
} else {
    out.println("No file uploaded");
}
%>
