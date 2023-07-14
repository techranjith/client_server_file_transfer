import socket

def receive_file():
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.bind(('localhost', 1234))
    server_socket.listen(1)

    print("Server is listening for connections...")

    client_socket, address = server_socket.accept()
    print("Connected with:", address)

    file_name = client_socket.recv(1024).decode()
    print("Receiving file:", file_name)
            
    print("File received successfully.")
    with open(file_name, 'rb') as file:
        file_contents = file.read().decode()
        print("File contents:\n", file_contents)
    
    client_socket.close()
    server_socket.close()

if __name__ == "__main__":
    receive_file()

