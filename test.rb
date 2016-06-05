#!/usr/bin/ruby
##
## Ruby CIS Test script for Linux
## by Nick Lalumiere
## rev 1.0
require 'open3'

$release = "/etc/os-release"

module CISTest
	def CISTest.host()
        cmd = "hostname"
        Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
               output = stdout.read
                print "Hostname: #{output}\n"
                end
        end

	def CISTest.fullcheck()
	cmd ="grep -m 1 -w 'PRETTY_NAME' #{$release} | sed 's/.*=//' | sed 's/.//;s/.$//'"
	Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
                        output = stdout.read
                        @full = "#{output}"
                        if output.size > 0
                        return true
                        else
                        end
                end
	end
	
	def CISTest.versioncheck()
	cmd ="grep -m 1 -w 'VERSION_ID' #{$release} | sed 's/.*=//' | sed 's/.//;s/.$//'"
        Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
                        output = stdout.read
                        @version = "#{output}"
                        if output.size > 0
                        return true
                        else
                        end
                end

        end


	def CISTest.susecheck()
	cmd = "grep -m 1 -w 'NAME' #{$release} | sed 's/.*=//' | grep 'SUSE'"
                Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
                        output = stdout.read
                        @distro = "#{output}"
                        if output.size > 0
                        return true
                        else
                        end
                end
	end

	def CISTest.ubuntucheck()
        cmd = "grep -m 1 -w 'NAME' #{$release} | sed 's/.*=//' | grep 'Ubuntu'"
                Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
                        output = stdout.read
                        @distro = "#{output}"
                        if output.size > 0
                        return true
                        else
                        end
                end
        end
	
	def CISTest.redhatcheck()
        cmd = "grep -m 1 -w 'Red Hat' /etc/redhat-release"
                Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
                        output = stdout.read
                        @distro = "#{output}"
                        if output.size > 0
                        return true
                        else
                        end
                end
        end

	def CISTest.fullver(title)
	title = title
	if CISTest.fullcheck() == true
		print "#{@full}\n"
	else
		print "None\n"
	end
	end

	def CISTest.ver(title)
        title = title
        if CISTest.versioncheck() == true
                print "#{@version}\n"
        else
                print "None\n"
        end
        end

	def CISTest.checkdistro(title)
	title = title
	print "#{title}"
	if CISTest.susecheck() == true
		CISTest.fullver("")
	elsif CISTest.ubuntucheck() == true
                CISTest.fullver("")
        elsif CISTest.redhatcheck() == true
                print "#{@distro}\n"
        else
		print "Distro not Supported!\n"
	end

	end

end

