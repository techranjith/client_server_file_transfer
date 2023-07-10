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

    with open(file_name, 'wb') as file:
        while True:
            data = client_socket.recv(1024)
            if not data:
                break
            file.write(data)

    print("File received successfully.")
    client_socket.close()
    server_socket.close()

if __name__ == "__main__":
    receive_file()

