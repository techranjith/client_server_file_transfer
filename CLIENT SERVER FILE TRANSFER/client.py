import socket

def send_file(file_name):
    client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    client_socket.connect(('localhost', 1234))

    print("Connected to the server.")

    client_socket.send(file_name.encode())

    with open(file_name, 'rb') as file:
        while True:
            data = file.read(1024)
            if not data:
                break
            client_socket.send(data)

    print("File sent successfully.")
    client_socket.close()

if __name__ == "__main__":
    file_name = 'file.txt'
    send_file(file_name)

