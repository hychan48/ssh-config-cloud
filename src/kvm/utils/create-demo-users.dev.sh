# sudo adduser username
sudo adduser --gecos "" --disabled-password username
echo "username:password" | sudo chpasswd

sudo adduser --gecos "" --ingroup sudo --disabled-password username
echo "username:password" | sudo chpasswd

# delete user
sudo deluser --remove-home username
