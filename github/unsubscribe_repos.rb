#!/usr/bin/env ruby

require 'octokit'

github_user = Octokit::Client.new(:access_token => ENV['GITHUB_API_KEY'])
github_user.auto_paginate = true

subscriptions = github_user.subscriptions()

