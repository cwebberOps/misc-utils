#!/usr/bin/env ruby

require 'octokit'

WHITELIST = [
 %r{opscode-cookbooks/},
 %r{cwebberOps/},
 %r{opsallthethings/},
 %r{puppetbestpractices/},
 %r{hangops/},
 %r{opscode/supermarket},
 %r{ladevops/}
]

github_user = Octokit::Client.new(:access_token => ENV['GITHUB_API_KEY'])
github_user.auto_paginate = true

subscriptions = github_user.subscriptions()

subscriptions.each do |sub|

  unsub = true
  WHITELIST.each do |whitelist|

    if whitelist =~ sub[:full_name]
      unsub = false
    end
  end

  if unsub
    if github_user.delete_subscription(sub[:full_name])
      puts "Unsubscribed from #{sub[:full_name]}"
    end
  end
end
