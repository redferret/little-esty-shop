module ApiHelper
  GIT_API = GithubAPI::V3::Client.new

  PROJECT_REPO = GIT_API.project_repo

  def project_repo_name
    PROJECT_REPO['name']
  end

  def project_repo_path
    PROJECT_REPO['html_url']
  end
end