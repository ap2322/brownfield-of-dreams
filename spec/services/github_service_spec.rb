require 'rails_helper'

describe 'GitHubService makes successful api calls' do
  it 'can make a json of repos', :vcr do
    service = GithubService.new
    repos = service.repos_json(ENV['GITHUB_TEST_TOKEN'])

    expect(repos).to be_a(Array)
    expect(repos[0]).to have_key 'name'
    expect(repos[0]).to have_key 'html_url'
  end

  it 'can make a json of followers', :vcr do
    service = GithubService.new
    followers = service.followers_json(ENV['GITHUB_TEST_TOKEN'])

    expect(followers).to be_a(Array)
    expect(followers[0]).to have_key 'html_url'
    expect(followers[0]).to have_key 'login'
  end

  it 'can make a json of followings', :vcr do
    service = GithubService.new
    followings = service.followings_json(ENV['GITHUB_TEST_TOKEN'])

    expect(followings).to be_a(Array)
    expect(followings[0]).to have_key 'html_url'
    expect(followings[0]).to have_key 'login'
  end

  it 'can make a json of a friend', :vcr do
    service = GithubService.new
    friend = service.friend_json('turingschool', ENV['GITHUB_TEST_TOKEN'])

    expect(friend).to be_a(Hash)
    expect(friend).to have_key 'name'
    expect(friend).to have_key 'html_url'
    expect(friend).to have_key 'login'
    expect(friend).to have_key 'email'
  end

end
