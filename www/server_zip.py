import os
import shutil
from http.server import SimpleHTTPRequestHandler, HTTPServer
from urllib.parse import urlparse

PORT = 8080
DIRECTORY = "/home/ns/www"

class ZipDownloadHandler(SimpleHTTPRequestHandler):
    def do_GET(self):
        parsed_path = urlparse(self.path)
        
        # Si la URL empieza con /zip/, procedemos a comprimir y descargar
        if parsed_path.path.startswith('/zip/'):
            parts = parsed_path.path.split('/')
            if len(parts) > 2 and parts[2]:
                project_name = parts[2]
                project_path = os.path.join(DIRECTORY, project_name)
                
                # Verificar si la carpeta del proyecto existe
                if os.path.isdir(project_path):
                    zip_filename = os.path.join(DIRECTORY, project_name)
                    
                    try:
                        # Crear el archivo ZIP
                        shutil.make_archive(zip_filename, 'zip', project_path)
                        final_zip_path = zip_filename + ".zip"
                        
                        # Enviar el archivo ZIP para descarga
                        self.send_response(200)
                        self.send_header("Content-Type", "application/zip")
                        self.send_header("Content-Disposition", f"attachment; filename={project_name}.zip")
                        self.end_headers()
                        
                        with open(final_zip_path, 'rb') as f:
                            shutil.copyfileobj(f, self.wfile)
                            
                        # Eliminar el ZIP temporal del servidor
                        os.remove(final_zip_path)
                        return
                    
                    except Exception as e:
                        self.send_error(500, f"Error al comprimir la carpeta: {str(e)}")
                        return
                else:
                    self.send_error(404, f"La carpeta '{project_name}' no existe.")
                    return

        # Para cualquier otra ruta (incluyendo qmlweb), actúa como servidor estático normal
        return SimpleHTTPRequestHandler.do_GET(self)

if __name__ == '__main__':
    os.chdir(DIRECTORY)
    server_address = ('0.0.0.0', PORT)
    httpd = HTTPServer(server_address, ZipDownloadHandler)
    print(f"Servidor web corriendo en http://192.168.0.35:{PORT}")
    httpd.serve_forever()
