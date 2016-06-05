#!/usr/bin/ruby
##
## Ruby CIS Test script for Linux
## by Nick Lalumiere
## rev 1.0
require './main.rb'

$os = "SuSe"

CISTest.checkdistro("Checking #{$os}...")

# Title
CISUtil.mainhead("CIS SUSE Linux 12/ openSUSE 13.2", "v1.0.0", "07-06-2015")

# CIS Partition Check
CISUtil.head("2 FileSystem Configuration")

part1=Main.new("2.1", "/tmp", "/etc/fstab", "nodev,noexec,nosuid")
part1.fscn
part2=Main.new("2.5", "/var", "/etc/fstab", "nil")
part2.fscn
part3=Main.new("2.6", "/var/tmp", "/etc/fstab", "bind")
part3.fscn
part4=Main.new("2.7", "/var/log", "/etc/fstab", "nil")
part4.fscn
part5=Main.new("2.8", "/var/log/audit", "/etc/fstab", "nil")
part5.fscn
part6=Main.new("2.9", "/home", "/etc/fstab", "nodev")
part6.fscn
part7=Main.new("2.11", "/media/cdrom", "/etc/fstab", "nodev,noexec,nosuid")
part7.fscn
part8=Main.new("2.14", "/dev/shm", "/etc/fstab", "nodev,noexec,nosuid")
part8.fscn

# CIS Main Modules
CISUtil.space()
fs1=Main.new("2.18", "cramfs", "98-CIS.conf", "nil")
fs1.moddisable
fs2=Main.new("2.19", "freevxfs", "98-CIS.conf", "nil")
fs2.moddisable
fs3=Main.new("2.20", "jffs2", "98-CIS.conf", "nil")
fs3.moddisable
fs4=Main.new("2.21", "hfs", "98-CIS.conf", "nil")
fs4.moddisable
fs5=Main.new("2.22", "hfsplus", "98-CIS.conf", "nil")
fs5.moddisable
fs6=Main.new("2.23", "squashfs", "98-CIS.conf", "nil")
fs6.moddisable
fs7=Main.new("2.24", "udf", "98-CIS.conf", "nil")
fs7.moddisable

# CIS FileSytem Automounting
CISUtil.space()
aum1=Main.new("2.25", "autofs", "nil", "nil")
aum1.servdisable

# CIS Secure Boot Settings
CISUtil.head("3 Secure Boot Settings")
boot1=Files.new("3.1", "600", "/boot/grub2/grub.cfg", "root", "root")
boot1.fullperm
boot2=Main.new("3.3", "set superusers", "/boot/grub2/grub.cfg", "nil")
boot2.fscn

# CIS Additional Process Hardening
CISUtil.space()
CISUtil.head("4 Additional Process Hardening")
ad1=Additional.new("4.1", "hard core 0", "/etc/security/limits.conf", "restric core dump")
ad1.configcheck
ad2=Additional.new("4.1", "fs.suid_dumpable", "nil", "0")
ad2.kerndisable
ad3=Additional.new("4.3", "kernel.randomize_va_space", "nil", "2")
ad3.kernenable
ad3=Additional.new("4.4", "prelink", "nil", "nil")
ad3.rpmcheck
#4.5

# CIS OS Services
CISUtil.space()
CISUtil.head("5 OS Services")

# Legacy Services
osserv1=Main.new("5.1.1", "ypserv", "nil", "nil")
osserv1.servdisable
osserv2=Additional.new("5.1.2", "ypbind", "nil", "nil")
osserv2.rpmcheck
osserv3=Main.new("5.1.3", "rsh", "nil", "nil")
osserv3.servdisable
osserv4=Additional.new("5.1.4", "rsh", "nil", "nil")
osserv4.rpmcheck
osserv5=Main.new("5.1.5", "talk", "nil", "nil")
osserv5.servdisable
osserv6=Additional.new("5.1.6", "talk", "nil", "nil")
osserv6.rpmcheck
osserv7=Main.new("5.1.7", "telnet", "nil", "nil")
osserv7.servdisable
osserv8=Main.new("5.1.8", "tftp", "nil", "nil")
osserv8.servdisable
osserv9=Main.new("5.1.9", "xinetd", "nil", "nil")
osserv9.servdisable
osserv10=Main.new("5.2", "chargen-udp", "nil", "nil")
osserv10.servdisable
osserv11=Main.new("5.3", "chargen", "nil", "nil")
osserv11.servdisable
osserv12=Main.new("5.4", "daytime-udp", "nil", "nil")
osserv12.servdisable
osserv13=Main.new("5.5", "daytime", "nil", "nil")
osserv13.servdisable
osserv14=Main.new("5.6", "echo-udp", "nil", "nil")
osserv14.servdisable
osserv15=Main.new("5.7", "echo", "nil", "nil")
osserv15.servdisable
osserv16=Main.new("5.8", "discard-udp", "nil", "nil")
osserv16.servdisable
osserv17=Main.new("5.9", "discard", "nil", "nil")
osserv17.servdisable
osserv18=Main.new("5.10", "time-udp", "nil", "nil")
osserv18.servdisable
osserv19=Main.new("5.11", "time", "nil", "nil")
osserv19.servdisable

# CIS Special Purpose Services
CISUtil.space()
CISUtil.head("6 Special Services")
spserv1=Additional.new("6.1", "xorg-x11", "nil", "nil")
spserv1.rpmcheck
spserv2=Main.new("6.2", "avahi-daemon", "nil", "nil")
spserv2.servdisable
spserv3=Main.new("6.3", "cups", "nil", "nil")
spserv3.servdisable
spserv4=Main.new("6.4", "dhcpd", "nil", "nil")
spserv4.servdisable
spserv5=Additional.new("6.5", "restrict -4  default kod notrap nomodify nopeer noquery", "/etc/ntp.conf", 
"NTP")
spserv5.configcheck
spserv6=Additional.new("6.5", "restrict -6  default kod notrap nomodify nopeer noquery", "/etc/ntp.conf", 
"NTP")
spserv6.configcheck
spserv7=Additional.new("6.5", "NTPD_OPTIONS=\"-g -u ntp:ntp", "/etc/sysconfig/ntp", "NTP")
spserv7.configcheck
spserv8=Additional.new("6.5", "server ntppool.aphysci.com", "/etc/ntp.conf", "NTP")
spserv8.configcheck
spserv9=Additional.new("6.6", "openldap2", "nil", "nil")
spserv9.rpmcheck
spserv10=Additional.new("6.6", "openldap2-client", "nil", "nil")
spserv10.rpmcheck
spserv11=Main.new("6.7", "nfsserver", "nil", "nil")
spserv11.servdisable
spserv12=Main.new("6.7", "rpcbind", "nil", "nil")
spserv12.servdisable
spserv13=Main.new("6.8", "named", "nil", "nil")
spserv13.servdisable
spserv14=Main.new("6.9", "vsftpd", "nil", "nil")
spserv14.servdisable
spserv15=Main.new("6.10", "apache2", "nil", "nil")
spserv15.servdisable
spserv16=Main.new("6.11", "dovecot", "nil", "nil")
spserv16.servdisable
spserv17=Main.new("6.12", "smb", "nil", "nil")
spserv17.servdisable
spserv18=Main.new("6.13", "squid", "nil", "nil")
spserv18.servdisable
spserv19=Main.new("6.14", "snmpd", "nil", "nil")
spserv19.servdisable
spserv20=Additional.new("6.15", "inet_interfaces = localhost", "/etc/postfix/main.cf", "Postfix")
spserv20.configcheck
spserv21=Main.new("6.16", "rsyncd", "nil", "nil")
spserv21.servdisable
spserv22=Additional.new("6.17", "biosdevname", "nil", "nil")
spserv22.rpmcheck

# CIS Network Configuration and Firewalls
CISUtil.space()
CISUtil.head("7 Network Configuration and Firewalls")
net1=Additional.new("7.1.1", "net.ipv4.ip_forward", "nil", "0")
net1.kerndisable
net2=Additional.new("7.1.2", "net.ipv4.conf.all.send_redirects", "nil", "0")
net2.kerndisable
net3=Additional.new("7.1.2", "net.ipv4.conf.default.send_redirects", "nil", "0")
net3.kerndisable
net4=Additional.new("7.2.1", "net.ipv4.conf.all.accept_source_route", "nil", "0")
net4.kerndisable
net5=Additional.new("7.2.1", "net.ipv4.conf.default.accept_source_route", "nil", "0")
net5.kerndisable
net6=Additional.new("7.2.2", "net.ipv4.conf.all.accept_redirects", "nil", "0")
net6.kerndisable
net7=Additional.new("7.2.2", "net.ipv4.conf.default.accept_redirects", "nil", "0")
net7.kerndisable
net8=Additional.new("7.2.3", "net.ipv4.conf.all.secure_redirects", "nil", "0")
net8.kerndisable
net9=Additional.new("7.2.3", "net.ipv4.conf.default.secure_redirects", "nil", "0")
net9.kerndisable
net10=Additional.new("7.2.4", "net.ipv4.conf.all.log_martians", "nil", "1")
net10.kernenable
net11=Additional.new("7.2.4", "net.ipv4.conf.default.log_martians", "nil", "1")
net11.kernenable
net12=Additional.new("7.2.5", "net.ipv4.icmp_echo_ignore_broadcasts", "nil", "1")
net12.kernenable
net13=Additional.new("7.2.6", "net.ipv4.icmp_ignore_bogus_error_responses", "nil", "1")
net13.kernenable
net14=Additional.new("7.2.7", "net.ipv4.conf.all.rp_filter", "nil", "1")
net14.kernenable
net15=Additional.new("7.2.7", "net.ipv4.conf.default.rp_filter", "nil", "1")
net15.kernenable
net16=Additional.new("7.2.8", "net.ipv4.tcp_syncookies", "nil", "1")
net16.kernenable

# IPv6
net17=Additional.new("7.3.1", "net.ipv6.conf.all.accept_ra", "nil", "0")
net17.kerndisable
net18=Additional.new("7.3.1", "net.ipv6.conf.default.accept_ra", "nil", "0")
net18.kerndisable
net19=Additional.new("7.3.2", "net.ipv6.conf.all.accept_redirects", "nil", "0")
net19.kerndisable
net20=Additional.new("7.3.2", "net.ipv6.conf.default.accept_redirects", "nil", "0")
net20.kerndisable
net21=Additional.new("7.3.3", "net.ipv6.conf.all.disable_ipv6 = 1", "/etc/sysctl.conf", "IPv6")
net21.configcheck
net22=Additional.new("7.3.3", "net.ipv6.conf.defaults.disable_ipv6 = 1", "/etc/sysctl.conf", "IPv6")
net22.configcheck
net23=Additional.new("7.3.3", "net.ipv6.conf.lo.disable_ipv6 = 1", "/etc/sysctl.conf", "IPv6")
net23.configcheck
CISUtil.space()

# TCP Wrappers
net24=Additional.new("7.4.1", "tcpd", "nil", "nil")
net24.rpminstalled
net25=Files.new("7.4.2", "644", "/etc/hosts.allow", "root", "root")
net25.fullperm
net26=Files.new("7.4.4", "644", "/etc/hosts.deny", "root", "root")
net26.fullperm
CISUtil.space()

# Uncommon Network Protocols
net28=Main.new("7.5.1", "dccp", "98-CIS.conf", "nil")
net28.moddisable
net29=Main.new("7.5.2", "sctp", "98-CIS.conf", "nil")
net29.moddisable
net30=Main.new("7.5.3", "rds", "98-CIS.conf", "nil")
net30.moddisable
net31=Main.new("7.5.4", "tipc", "98-CIS.conf", "nil")
net31.moddisable
#7.6 Wireless
net32=Main.new("7.7", "SuSEfirewall2", "nil", "nil")
net32.servenable
net33=Main.new("7.7", "SuSEfirewall2_init", "nil", "nil")
net33.servenable
net34=Additional.new("7.8", 'FW_TRUSTED_NETS="172.16.0.0/16 192.168.1.0/24', "/etc/sysconfig/SuSEfirewall2", 
"SuSE Firewall")
net34.configcheck

# CIS Logging and Auditing
CISUtil.space()
CISUtil.head("8 Logging and Auditing")
# Auditd
log1=Additional.new("8.1.1.1", 'max_log_file = 12', "/etc/audit/auditd.conf", "auditd")
log1.configcheck
log2=Additional.new("8.1.1.2", 'space_left_action = email', "/etc/audit/auditd.conf", "auditd")
log2.configcheck
log3=Additional.new("8.1.1.2", 'action_mail_acct = root', "/etc/audit/auditd.conf", "auditd")
log3.configcheck
log4=Additional.new("8.1.1.2", 'admin_space_left_action = halt', "/etc/audit/auditd.conf", "auditd")
log4.configcheck
log5=Additional.new("8.1.1.3", 'max_log_file_action = keep_logs', "/etc/audit/auditd.conf", "auditd")
log5.configcheck
log6=Main.new("8.1.2", "auditd", "nil", "nil")
log6.servenable
log7=Additional.new("8.1.3", 'GRUB_CMDLINE_LINUX="audit=1', "/etc/default/grub", "auditd")
log7.configcheck

# Audit Rules
CISUtil.space()
log8=Main.new("8.1.4", "Record Events that Modify Date/Time Info", "/etc/audit/audit.rules", "nil")
log8.fscn
log9=Main.new("8.1.5", "Record Events that Modify User/Group Info", "/etc/audit/audit.rules", "nil")
log9.fscn
log10=Main.new("8.1.6", "Record Events that Modify the Systems's Network Environment", 
"/etc/audit/audit.rules", "nil")
log10.fscn
log11=Main.new("8.1.7", "Record Events that Modify the System's Mandatory Access", "/etc/audit/audit.rules", 
"nil")
log11.fscn
log12=Main.new("8.1.8", "Collect Login/Logout Events", "/etc/audit/audit.rules", "nil")
log12.fscn
log13=Main.new("8.1.9", "Collect Session Initiation Information", "/etc/audit/audit.rules", "nil")
log13.fscn
log14=Main.new("8.1.10", "Collect Discretionary Access Acontrol Permission Modification Events", 
"/etc/audit/audit.rules", "nil")
log14.fscn
log15=Main.new("8.1.11", "Collect Unsuccessful Unauth Access Attempts to Files", "/etc/audit/audit.rules", 
"nil")
log15.fscn
#8.1.12 Collect Use of Privileged Commands
log16=Main.new("8.1.13", "Collect Successful File System Mounts", "/etc/audit/audit.rules", "nil")
log16.fscn
log17=Main.new("8.1.14", "Collect File Deletion Events by User", "/etc/audit/audit.rules", "nil")
log17.fscn
log18=Main.new("8.1.15", "Collect Changes to System Admin Scope", "/etc/audit/audit.rules", "nil")
log18.fscn
log19=Main.new("8.1.16", "Collect System Admin Actions", "/etc/audit/audit.rules", "nil")
log19.fscn
log20=Main.new("8.1.17", "Collect Kernel Module Loading/Unloading", "/etc/audit/audit.rules", "nil")
log20.fscn
log21=Additional.new("8.1.18", '-e 2', "/etc/audit/audit.rules", "auditd")
log21.configcheck

# Rsyslog
CISUtil.space()
log22=Additional.new("8.2.1", "rsyslog", "nil", "nil")
log22.rpminstalled
log23=Main.new("8.2.2", "rsyslog", "nil", "nil")
log23.servenable
log24=Additional.new("8.2.5", '"*.* @@192.168.1.47"', "/etc/rsyslog.d/remote.conf", "rsyslog")
log24.configcheck

# Aide
CISUtil.space()
log25=Additional.new("8.3.1", "aide", "nil", "nil")
log25.rpminstalled
log26=Additional.new("8.3.2", "aide --check", "nil", "nil")
log26.cronscan

# CIS System Access, Authentication and Authorization
CISUtil.space()
CISUtil.head("9 System Access, Authentication and Authorization")
# Cron
auth1=Main.new("9.1.1", "cron", "nil", "nil")
auth1.servenable
auth2=Files.new("9.1.2", "600", "/etc/crontab", "root", "root")
auth2.fullperm
auth3=Files.new("9.1.3", "600", "/etc/cron.hourly", "root", "root")
auth3.fullperm
auth4=Files.new("9.1.4", "600", "/etc/cron.daily", "root", "root")
auth4.fullperm
auth5=Files.new("9.1.5", "600", "/etc/cron.weekly", "root", "root")
auth5.fullperm
auth6=Files.new("9.1.6", "600", "/etc/cron.monthly", "root", "root")
auth6.fullperm
auth7=Files.new("9.1.7", "600", "/etc/cron.d", "root", "root")
auth7.fullperm
auth8=Files.new("9.1.8", "600", "/etc/cron.allow", "root", "root")
auth8.fullperm
auth9=Files.new("9.1.8", "600", "/etc/at.allow", "root", "root")
auth9.fullperm

CISUtil.space()
# SSH
auth10=Additional.new("9.2.1", 'Protocol 2', "/etc/ssh/sshd_config", "SSH")
auth10.configcheck
auth11=Additional.new("9.2.2", 'LogLevel INFO', "/etc/ssh/sshd_config", "SSH")
auth11.configcheck
auth12=Files.new("9.2.3", "600", "/etc/ssh/sshd_config", "root", "root")
auth12.fullperm
auth13=Additional.new("9.2.4", 'X11Forwarding no', "/etc/ssh/sshd_config", "SSH")
auth13.configcheck
auth14=Additional.new("9.2.5", 'MaxAuthTries 4', "/etc/ssh/sshd_config", "SSH")
auth14.configcheck
auth15=Additional.new("9.2.6", 'IgnoreRhosts yes', "/etc/ssh/sshd_config", "SSH")
auth15.configcheck
auth16=Additional.new("9.2.7", 'HostbasedAuthentication no', "/etc/ssh/sshd_config", "SSH")
auth16.configcheck
auth17=Additional.new("9.2.8", 'PermitRootLogin no', "/etc/ssh/sshd_config", "SSH")
auth17.configcheck
auth18=Additional.new("9.2.9", 'PermitEmptyPasswords no', "/etc/ssh/sshd_config", "SSH")
auth18.configcheck
auth19=Additional.new("9.2.10", 'PermitUserEnvironment no', "/etc/ssh/sshd_config", "SSH")
auth19.configcheck
auth20=Additional.new("9.2.11", 'Ciphers aes128-ctr,aes192-ctr,aes256-ctr', "/etc/ssh/sshd_config", "SSH")
auth20.configcheck
auth21=Additional.new("9.2.12", 'ClientAliveInterval 1200', "/etc/ssh/sshd_config", "SSH")
auth21.configcheck
auth22=Additional.new("9.2.12", 'ClientAliveCountMax 0', "/etc/ssh/sshd_config", "SSH")
auth22.configcheck
auth23=Additional.new("9.2.13", 'AllowGroups sshlogin', "/etc/ssh/sshd_config", "SSH")
auth23.configcheck
auth24=Additional.new("9.2.14", 'Banner /etc/issue.net', "/etc/ssh/sshd_config", "SSH")
auth24.configcheck

CISUtil.space()
# PAM
auth25=Main.new("9.3.1", 'pam_cracklib.so', "/etc/pam.d/common-password", "retry=3 minlen=8 dcredit=-1 
ucredit=-1 lcredit=-1 ocredit=-1")
auth25.fscn
auth26=Main.new("9.3.2", 'pam_tally2.so', "/etc/pam.d/common-auth", "onerr=fail audit silent deny=5 
unlock_time=900")
auth26.fscn
auth27=Main.new("9.3.2", "pam_tally2.so", "/etc/pam.d/common-account", "nil")
auth27.fscn
auth28=Main.new("9.3.3", 'pam_pwhistory.so', "/etc/pam.d/common-password", "remember=5")
auth28.fscn
auth29=Main.new("9.5", 'pam_wheel.so', "/etc/pam.d/su", "group=wheel")
auth29.fscn

# CIS User Accounts and Environment
CISUtil.space()
CISUtil.head("10 User Accounts and Environment")
user1=Main.new("10.1.1", 'PASS_MAX_DAYS', "/etc/login.defs", "90")
user1.fscn
user2=Main.new("10.1.2", 'PASS_MIN_DAYS', "/etc/login.defs", "7")
user2.fscn
user3=Main.new("10.1.3", 'PASS_WARN_AGE', "/etc/login.defs", "7")
user3.fscn
#10.2 script Disable System Accounts
#10.3 Default root group
user4=Main.new("10.4", 'pam_umask.so', "/etc/pam.d/common-session", "umask=0077")
user4.fscn
#10.5 Lock Inactive Accounts

# CIS Warning Banners
CISUtil.space()
CISUtil.head("11 Warning Banners")
ban1=Files.new("11.1", "644", "/etc/issue", "root", "root")
ban1.fullperm
ban2=Files.new("11.1", "644", "/etc/issue.net", "root", "root")
ban2.fullperm
ban3=Files.new("11.1", "644", "/etc/motd", "root", "root")
ban3.fullperm
ban4=Main.new("11.2.", 'Authorized users only.', "/etc/issue", "nil")
ban4.fscn
ban5=Main.new("11.2", 'Authorized users only.', "/etc/issue.net", "nil")
ban5.fscn
ban6=Main.new("11.2", 'APS owns this system.', "/etc/motd", "nil")
ban6.fscn

# CIS Verify System File Permissions
CISUtil.space()
CISUtil.head("12 Verify System File Permissions")
fperm1=Files.new("12.2", "644", "/etc/passwd", "root", "root")
fperm1.fullperm
fperm2=Files.new("12.3", "640", "/etc/shadow", "root", "shadow")
fperm2.fullperm
fperm3=Files.new("12.4", "644", "/etc/group", "root", "root")
fperm3.fullperm
CISUtil.space()
CISUtil.footer()
