#!/usr/bin/ruby
##
## Ruby CIS Test script for Linux 
## by Nick Lalumiere
## rev 1.0
require 'open3'
require './test.rb'

$pass = "-- Pass"
$fail = "-- \e[31mFailed!\e[0m"

module CISUtil
	def CISUtil.mainhead(title, version, date)
	puts "#---------------------------------------------"
	puts "#"
	puts "#		#{title} ruby Test"
	puts "#		Benchmark #{version} - #{date}"
	puts "#		by Nick Lalumiere"
	puts "#"
	end

	def CISUtil.head(title)
	title = title
	puts "#---------------------------------------------"
	puts "#"
	puts "#		#{title}"
	puts "#"
	puts "#---------------------------------------------"
	end

	def CISUtil.space()
	puts ""
	end
	
	def CISUtil.footer()
	puts "#---------------------------------------------"
	puts " "
	CISTest.host()
	CISTest.fullver("")
	puts "Completed "
	cmd = "date"
	Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
                output = stdout.read
		print "#{output}\n"
		end
        puts " "
	end
	
	def CISUtil.filescn(num, attr, file, option)
	num = num
        attr = attr
	file = file
	option = option
	if option == "nil"		
		print "#{num} Checking -- '#{attr}' exists in file #{file}: "
		cmd = "grep -w '#{attr}' '#{file}'"
	else
        	print "#{num} Checking -- '#{attr}' exists in file #{file} with options: #{option} "
        	cmd = "grep -w '#{attr}' '#{file}' | grep '#{option}'"
	end
        Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
                output = stdout.read
                if output.size > 0
		return true
                else
			cmd = "grep -w ^'#{attr}' '#{file}'"
			Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
                	output = stdout.read
			if output.size > 0
			$fscnresults = "#{output}"
			return false
			else
			end
			end
                end
        end
        end

	

	def CISUtil.moddisabled(num, attr)
	num = num
	attr = attr
	print "#{num} Module #{attr} is "
        cmd = "/sbin/lsmod | grep '#{attr}'"
        Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
                output = stdout.read
                if output.size > 0
		@modresult = 0
                print "enabled #{$fail}\n"
                else
		@modresult = 1
                print "disabled #{$pass}\n"
                end
        end
	end

	def CISUtil.modres(attr, file)
        attr = attr
	file = file
	config = "/etc/modprobe.d"
	if @modresult == 1
        	print "Results from #{config}/#{file}: "
		system("grep -w #{attr} #{config}/#{file}")
		end
        end

	def CISUtil.sdisabled(num, attr)
	num = num
        attr = attr
        title2 = "#{num} Service #{attr} is"
	cmd = "systemctl is-enabled '#{attr}'"
	Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
		output = stdout.read
		errout = stderr.read
		if output.size > 8 or errout.size > 1
		print "#{title2} disabled " 
		print "#{$pass}\n"
                else
		print "#{title2} enabled "
                print "#{$fail}\n"
                end
	end
	end

	def CISUtil.senabled(num, attr)
	num = num
        attr = attr
        title2 = "#{num} Service #{attr} is"
        cmd = "systemctl is-enabled '#{attr}'"
        Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
                output = stdout.read
                errout = stderr.read
                if output.size > 8 or errout.size > 1
                print "#{title2} disabled "
                print "#{$fail}\n"
                else
                print "#{title2} enabled "
                print "#{$pass}\n"
                end
        end
        end


	def CISUtil.kdisabled(num, attr, option)
	num = num
        attr = attr
	option = option
        title2 = "#{num} Kernel setting disabled: #{attr} = #{option}"
        cmd = "sysctl '#{attr}'"
        Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
                output = stdout.read
                if "#{output}" =~ /[0]/
		print "#{title2} #{$pass}\n"
		else
		print "#{title2} #{$fail}\n"
		puts "Results: #{output}"
                end
        end
        end

	def CISUtil.kenabled(num, attr, option)
        num = num
	attr = attr
        option = option
        title2 = "#{num} Kernel setting enabled: #{attr} = #{option}"
        cmd = "sysctl '#{attr}'"
        Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
                output = stdout.read
                if "#{output}" =~ /[1-9]/
                print "#{title2} #{$pass}\n"
                else
                print "#{title2} #{$fail}\n"
                puts "Results: #{output}"
                end
        end
        end


	def CISUtil.rpm(num, attr)
	num = num
        attr = attr
        title2 = "#{num} Package #{attr} is"
        cmd = "rpm -q '#{attr}'"
        Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
                output = stdout.read
		if "#{output}" =~ /x86/ or "#{output}" =~ /x64/
                print "#{title2} installed "
                print "#{$fail}\n"
                else
                print "#{title2} not installed "
                print "#{$pass}\n"
                end
        end
        end

	def CISUtil.rpminst(num, attr)
	num = num
        attr = attr
        title2 = "#{num} Package #{attr} is"
        cmd = "rpm -q '#{attr}'"
        Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
                output = stdout.read
                if "#{output}" =~ /x86/ or "#{output}" =~ /x64/
                print "#{title2} installed "
                print "#{$pass}\n"
                else
                print "#{title2} not installed "
                print "#{$fail}\n"
                end
        end
        end


	def CISUtil.configfile(num, attr, file, option)
        num = num
	attr = attr
        file = file
	option = option
        print "#{num} Checking #{option} is configured with: \"#{attr}\" setting in #{file} "
        File.readlines("#{file}").grep(/#{attr}/).any?
        end
	
	def CISUtil.filetest(num, file)
	num = num
	file = file
	print "#{num} Checking File -- #{file} "
	end
	
	def CISUtil.perm(perm, file)
        perm = perm
        file = file
	title2 = "Permission:"
        cmd = "stat --format '%a' '#{file}'"
        Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
                output = stdout.read
                stderr = stderr.read
		$permresults = "#{output}"
                if stderr.size < 1 and "#{output}" =~ /#{perm}/
		return true
                else
                end
        end
        end

	def CISUtil.ownuser(file, owner)
        file = file
	owner = owner
	title2 = "Owner:"
        cmd = "stat -c '%U' '#{file}'"
        Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
                output = stdout.read
                stderr = stderr.read
		$ownerresults = "#{output}"
                if stderr.size < 1 and "#{output}" =~ /#{owner}/
		return true
                else
                end
	end
	end
	
	def CISUtil.owngroup(file, group)
        file = file
	group = group
	title2 = "Group:"
        cmd = "stat -c '%G' '#{file}'"
        Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
                output = stdout.read
                stderr = stderr.read
		$groupresults = "#{output}"
                if stderr.size < 1 and "#{output}" =~ /#{group}/
		return true
                else
                end
        end
	end

	def CISUtil.cronscan(num, attr)
	num = num
        attr = attr
        print "#{num} Checking Cron Job -- #{attr} : "
        cmd = "crontab -u root -l | grep '#{attr}'"
        Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
                output = stdout.read
                if output.size > 1 and "#{output}" =~ /#{attr}/
                print "Exists #{$pass}\n"
		print "Results: #{output}"
                else
                print "Doesn't Exist #{$fail}\n"
                end
        end
        end


end

class Main
	include CISUtil
#	$config = "/home/itadmin/security/etc"

	def initialize(num, attr, file, option)
	@num = num
	@attr = attr
        @file = file
        @option = option

	end

	def fscn
	call1 = CISUtil.filescn("#{@num}", "#{@attr}", "#{@file}", "#{@option}")
        if File.exist?("#{@file}")
		if call1 == true
                	print "#{$pass}\n"
                        elsif call1 == false
                        print "#{$fail}\n"
			puts "  Results: #{$fscnresults}\n"
			else
			print "#{$fail}\n"
                        end
		else
		print "#{@num} File #{@file} does not exist "
                print "#{$fail}\n"
                end
	end

	def moddisable
	CISUtil.moddisabled("#{@num}", "#{@attr}")
	CISUtil.modres("#{@attr}", "#{@file}")
	end

	def servdisable
	CISUtil.sdisabled("#{@num}", "#{@attr}")
        end
	
	def servenable
        CISUtil.senabled("#{@num}", "#{@attr}")
        end

		
end

class Additional
	include CISUtil

        def initialize(num, attr, file, option)
	@num = num
        @attr = attr
        @file = file
        @option = option

        end
	
	def configcheck
        if CISUtil.configfile("#{@num}", "#{@attr}", "#{@file}", "#{@option}")
        	print "#{$pass}\n"
                else
                print "#{$fail}\n"
                end
        end
	
	def kerndisable
        CISUtil.kdisabled("#{@num}", "#{@attr}", "#{@option}")
        end

	def kernenable
        CISUtil.kenabled("#{@num}", "#{@attr}", "#{@option}")
        end


	def rpmcheck
        CISUtil.rpm("#{@num}", "#{@attr}")
        end

	def rpminstalled
        CISUtil.rpminst("#{@num}", "#{@attr}")
        end

	def cronscan
        CISUtil.cronscan("#{@num}", "#{@attr}")
        end



end

class Files
        include CISUtil

        def initialize(num, perm, file, owner, group)
        @num = num
	@perm = perm
        @file = file
	@owner = owner
        @group = group

        end
	
	def fullperm
	call1 = CISUtil.perm("#{@perm}", "#{@file}")
	call2 = CISUtil.ownuser("#{@file}", "#{@owner}")
	call3 = CISUtil.owngroup("#{@file}", "#{@group}")
	if File.exist?("#{@file}")
		CISUtil.filetest("#{@num}", "#{@file}")
			if call1 && call2 && call3 == true
			print "#{$pass}\n"
			else
			print "#{$fail}\n"
			end

		 	if call1 == true
			print "  Permissions: #{@perm} "
                        print "#{$pass}\n"
                	else
			print "  Permissions: #{$permresults} "
			print "#{$fail} -- Should be #{@perm}\n"
			end

			if call2 == true
			print "  Owner: #{@owner} "
                        print "#{$pass}\n"
               	 	else
			print "  Owner: #{$ownerresults} "
                        print "#{$fail} -- Should be #{@owner}\n"
                	end

                	if call3 == true
                        print "  Group: #{@group} "
			print "#{$pass}\n"
                	else
			print "  Group: #{$groupresults} "
                        print "#{$fail} -- Should be #{@group}\n"
                	end
		CISUtil.space()
	else
		print "#{@num} File #{@file} does not exist "
                print "#{$fail}\n"
		CISUtil.space()
                end

        end

        def permissions
        if File.exist?("#{@file}")
                if CISUtil.perm("#{@perm}", "#{@file}") == true
			print "  Permission: #{@perm} "
			print "#{$pass}\n"
		else
			print "  Permissions: #{$permresults} "
                        print "#{$fail} -- Should be #{@perm}\n"
		end
        else
                print "#{@num} File #{@file} does not exist "
                print "#{$fail}\n"
                end

	
	end

	def ownership
        if File.exist?("#{@file}")
                if CISUtil.ownuser("#{@file}", "#{@owner}") == true
			print "  Owner: #{@owner} "
			print "#{$pass}\n"
		else
			print "  Owner: #{$ownerresults} "
                        print "#{$fail} -- Should be #{@owner}\n"

		end
                if CISUtil.owngroup("#{@file}", "#{@group}") == true
			print "  Group: #{@group} "
			print "#{$pass}\n"
		else
			print "  Group: #{$groupresults} "
                        print "#{$fail} -- Should be #{@group}\n"

		end
        else
                print "#{@num} File #{@file} does not exist "
                print "#{$fail}\n"
                end

        
	end
end

