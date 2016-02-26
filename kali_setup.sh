#!/bin/bash

#############################################################################
# Script to set up tools used in The Hackers Playbook 2. Tools which are 
# included in Kali Rolling 2016.1 by default have been omitted.  
# HTTPScreenShotdependancy install also modified to remove swig2.0 which is
# depricated. --full flag used to do "basic" first run set up
#############################################################################


function pause(){
	read -p "Pres ENTER to continue..."
}

function installationPrompt(){
	printf "\n"
	echo "########################################################"
	printf "	 Installing %s\n" $1
	echo "########################################################"
	printf "\n"
}

# update the distro and setup msfconsole for first use
# requires --full flag
if [[ $1 == '--full' ]]; then
	# Uncomment the following 3 lines to update to Kali Rolling
	# cat << EOF > /etc/apt/sources.list
	# deb http://http.kali.org/kali kali-rolling main non-free contrib
	# EOF
	echo "Change password..."
	passwd	
	sed -i 's/kali/android-66756b6e6b616c69/g' /etc/hostname
	sed -i 's/kali/android-66756b6e6b616c69/g' /etc/hosts	
	apt-get update
	apt-get upgrade -y
	apt-get dist-upgrade -y
	service postgresql start
	msfdb init
fi

# HTTPScreenShot
installationPrompt HTTPScreenShot
pip install selenium
git clone https://github.com/breenmachine/httpscreenshot.git /opt/httpscreenshot
cd /opt/httpscreenshot
sed -i 's/swig2.0//g' install-dependencies.sh #removing depricated package
chmod +x install-dependencies.sh && ./install-dependencies.sh

#SMBExec
installationPrompt SMBExec
git clone https://github.com/pentestgeek/smbexec.git /opt/smbexec
printf "\nSelect Option 1 and accept all defaults to start installation\n"
pause
cd /opt/smbexec && ./install.sh
printf "\nSelect Option 4 to complete installation, then 5 to exit"
pause
./install.sh

# GitRob
installationPrompt GitRob
git clone https://github.com/michenriksen/gitrob.git /opt/gitrob
gem install bundler
service postgresql start
printf "\n\n\nEnter the following commands...\n\n"
echo "createuser -s gitrob --pwprompt"
echo "createdb -O gitrob gitrob"
echo "exit"
printf "\n\n"
pause
su postgres
printf "\nContinuing installation...\n"
cd /opt/gitrob/bin
gem install gitrob

#Cloning a number of git repos
printf "\nCloning repos for many tools and scripts\n"
git clone https://github.com/Dionach/CMSmap /opt/CMSmap
git clone https://github.com/MooseDojo/praedasploit /opt/praedasploit
git clone https://github.com/cheetz/Easy-P.git /opt/Easy-P
git clone https://github.com/cheetz/Password_Plus_One /opt/Password_Plus_One
git clone https://github.com/cheetz/PowerShell_Popup /opt/PowerShell_Popup
git clone https://github.com/cheetz/icmpshock /opt/icmpshock
git clone https://github.com/cheetz/brutescrape /opt/brutescrape
git clone https://www.github.com/cheetz/reddit_xss /opt/reddit_xss
git clone https://github.com/tcstool/NoSQLMap.git /opt/NoSQLMap
git clone https://github.com/samratashok/nishang /opt/nishang
git clone https://github.com/DanMcInerney/net-creds.git /opt/net-creds
git clone https://github.com/sophron/wifiphisher.git /opt/wifiphisher
git clone https://github.com/pentestgeek/phishing-frenzy.git /var/www/phishing-frenzy

#Discover Scripts
installationPrompt Discover
git clone https://github.com/leebaird/discover.git /opt/discover
cd /opt/discover && ./update.sh

#DSHashes
installationPrompt DSHashes
wget http://ptscripts.googlecode.com/svn/trunk/dshashes.py -O /opt/NTDSXtract/dshashes.py

#Spiderfoot
installationPrompt Spiderfoot
mkdir /opt/spiderfoot/ && cd /opt/spiderfoot
wget http://sourceforge.net/projects/spiderfoot/files/spiderfoot-2.3.0-src.tar.gz/download
tar xzvf download
pip install lxml
pip install netaddr
pip install M2Crypto
pip install cherrypy
pip install mako

# PowerSploit
installationPrompt PowerSploit
git clone https://github.com/mattifestation/PowerSploit.git /opt/PowerSploit
cd /opt/PowerSploit && wget https://raw.githubusercontent.com/obscuresec/random/master/StartListener.py && wget https://raw.githubusercontent.com/darkoperator/powershell_scripts/master/ps_encoder.py

#Veil-Framework
installationPrompt Veil
git clone https://github.com/Veil-Framework/Veil /opt/Veil
cd /opt/Veil/ && ./Install.sh -c