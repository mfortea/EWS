sudo apt update
sudo apt install -y git python3-pip build-essential wget python3-dev python3-venv python3-wheel libfreetype6-dev 
sudo apt install -y libxml2-dev libzip-dev libldap2-dev libsasl2-dev python3-setuptools node-less libjpeg-dev zlib1g-dev libpq-dev libxslt1-dev 
sudo apt install -y libldap2-dev libtiff5-dev libjpeg8-dev libopenjp2-7-dev liblcms2-dev libwebp-dev libharfbuzz-dev libfribidi-dev libxcb1-dev
sudo useradd -m -d /opt/odoo14 -U -r -s /bin/bash odoo14
sudo apt install postgresql
sudo su - postgres -c "createuser -s odoo14"
sudo wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.bionic_amd64.deb
sudo apt install -y./wkhtmltox_0.12.5-1.bionic_amd64.deb
su - "odoo14" <<SHT
  git clone https://www.github.com/odoo/odoo --depth 1 --branch 14.0 /opt/odoo14/odoo
  cd /opt/odoo14
  python3 -m venv odoo-venv
  source odoo-venv/bin/activate
  pip3 install wheel
  pip3 install -r odoo/requirements.txt
  deactivate
  mkdir /opt/odoo14/odoo-custom-addons
SHT
exit
sudo cp ficheros/odoo14.conf /etc/odoo14.conf
sudo cp ficheros/odoo14.service /etc/systemd/system/odoo14.service
sudo systemctl daemon-reload
sudo systemctl enable --now odoo14