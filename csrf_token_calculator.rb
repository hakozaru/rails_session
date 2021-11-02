#!/usr/bin/env ruby
authenticity_token = ARGV[0]

# decode
masked_token = Base64.strict_decode64(authenticity_token)

# unmask
one_time_pad = masked_token[0...31]
encrypted_csrf_token = masked_token[32..-1]

encrypted_csrf_token_bytes = encrypted_csrf_token.bytes
one_time_pad.each_byte.with_index { |c, i| encrypted_csrf_token_bytes[i] ^= c }
csrf_token = encrypted_csrf_token_bytes.pack("C*")

puts Base64.encode64(csrf_token)
