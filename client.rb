require 'socket'

HOST = '127.0.0.1'
PORT = 54321

begin
  socket = TCPSocket.new(HOST, PORT)

  puts "Socket connected on #{HOST}:#{PORT}"

  # Simulate a TCP Handshake
  syn = '[SYN] Request to synchronize'
  socket.puts syn
  puts "Sent #{syn}"

  syn_ack = socket.gets&.chomp
  puts "Received #{syn_ack}"

  puts 'Sending ACK...'
  ack = "[ACK] Acknowledge recieving SYN-ACK: #{syn_ack}"
  socket.puts ack
  ###

  loop do
    puts socket.gets # 'Enter a query (or type DISCONNECT):'
    input = gets.chomp
    socket.puts input
    break if input == "DISCONNECT"

    puts socket.gets # "[RESULT] ..."
  end
rescue Errno::ECONNREFUSED
  puts "[Error] Connection refused, are you sure server is running?"
rescue Errno::ECONNRESET
puts "[Error] Connection lost (server crashed or reset)"
end
