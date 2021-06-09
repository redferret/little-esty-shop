module ApiHelper
  extend self

  def production
    github_api = GithubAPI::V3::Client.new

    @@project_repo ||= github_api.project_repo
  end

  def development
    @@project_repo ||= {'name'=>'little-esty-shop', 'html_url'=>'https://github.com/redferret/little-esty-shop'}
  end

  def project_repo_name
    @@project_repo['name']
  end

  def project_repo_path
    @@project_repo['html_url']
  end
end