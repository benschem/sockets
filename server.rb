require 'socket'

HOST = '127.0.0.1'
PORT = 54321

server = TCPServer.new(HOST, PORT)
puts "Server running on #{HOST}:#{PORT}"

loop do
  client_socket = server.accept
  Thread.new(client_socket) do |socket|
    puts 'Client connected!'

    # Simulate a TCP Handshake
    syn = socket.gets&.chomp
    puts "Received #{syn}"

    puts 'Sending SYN-ACK...'
    syn_ack = "[SYN-ACK] Acknowledge recieving SYN: #{syn}"
    socket.puts syn_ack

    ack = socket.gets&.chomp
    puts "Recieved ACK #{ack}"

    puts ' TCP socket connection established.'
    puts ' Waiting for query...'
    ###

    loop do
      socket.puts 'Enter a query (or type DISCONNECT):'
      query = socket.gets.chomp
      puts "Received #{query}"
      break if query.nil? || query.chomp == 'DISCONNECT'

      puts "Performing #{query}..."
      result = query
      puts "Sending result: #{result}"
      socket.puts "[RESULT] #{result}"
    end

    puts "Client disconnected."
    socket.close
  end
end
