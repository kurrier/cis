#!/usr/bin/ruby
##
## Ruby CIS Test script for Linux
## by Nick Lalumiere
## rev 1.0
require './main.rb'
require 'highline/import'

def yesno(prompt = 'Continue?', default = true)
	confirm = ask("Continue? [Y/N] ") { |yn| yn.limit = 1, yn.validate = /[yn]/i }
	exit unless confirm.downcase == 'y'
end

puts "Hello there!"

CISTest.host()
CISTest.checkdistro("Checking Distro...")
if CISTest.susecheck() == true
	@dist = "SuSe"
elsif CISTest.ubuntucheck() == true
	@dist = "Ubuntu"
elsif CISTest.redhatcheck() == true
	@dist = "Red Hat"
else
	@dist = "nil"
end

puts "Linux Distro is #{@dist}. Will run #{@dist} test."
puts yesno("")

if #{@dist} == "SuSe"
	cmd = "./suse.rb | tee suse-test.log"
	Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
               output = stdout.read
                print "Hostname: #{output}\n"
                end
else
end

puts "Complete"

