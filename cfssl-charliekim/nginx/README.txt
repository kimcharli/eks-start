cat nginx/default | ssh ubuntu@www.charliekim.org sudo tee /etc/nginx/sites-available/default
cat work/host-www/host-www-server.pem | ssh ubuntu@www.charliekim.org sudo tee /etc/ssl/www.charliekim.org.crt
cat work/host-www/host-www-server-key.pem | ssh ubuntu@www.charliekim.org sudo tee /etc/ssl/www.charliekim.org.key
openssl s_client -connect www.charliekim.org:443


