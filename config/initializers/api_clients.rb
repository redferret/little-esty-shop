# To keep us from over shooting our limited number of API calls
case ENV.fetch("RAILS_ENV")
when 'development'
  PROJECT_REPO = {'name'=>'little-esty-shop', 'html_url'=>'https://github.com/redferret/little-esty-shop'}
when 'production'
  # Bootup the client for the Github API
  github_api_client = GithubAPI::V3::Client.new

  PROJECT_REPO = github_api_client.project_repo
end

