YOUR_NAME = "YOUR NAME HERE"

require 'digest/md5'
REALM = "middle_earth"
YOUR_USERNAME = "admin"
USERS_TABLE = { "some_user"=> "bad_plain_text_password", #plain text password
                YOUR_USERNAME => Digest::MD5.hexdigest([YOUR_USERNAME,REALM,"your_password"].join(":")), #ha1 digest password  
              }
              
=begin

See http://api.rubyonrails.org/classes/ActionController/HttpAuthentication/Basic.html
for more details on how to use
authenticate_or_request_with_http_digest

=end

