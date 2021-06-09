require_relative 'http_status_codes'

module ApiExceptions
  include HttpStatusCodes

  attr_reader :response

  GithubAPIError = Class.new(StandardError)
  BadRequestError = Class.new(GithubAPIError)
  UnauthorizedError = Class.new(GithubAPIError)
  ForbiddenError = Class.new(GithubAPIError)
  ApiRequestsQuotaReachedError = Class.new(GithubAPIError)
  NotFoundError = Class.new(GithubAPIError)
  UnprocessableEntityError = Class.new(GithubAPIError)
  ApiError = Class.new(GithubAPIError)

  def response_successful?
    response.status == HTTP_SUCCESS
  end

  # handles the specific http status and raises the error for the user
  def http_error
    case response.status
    when HTTP_BAD_REQUEST_CODE
      BadRequestError
    when HTTP_UNAUTHORIZED_CODE
      UnauthorizedError
    when HTTP_FORBIDDEN_CODE
      return ApiRequestsQuotaReachedError if api_requests_quota_reached?
      ForbiddenError
    when HTTP_NOT_FOUND_CODE
      NotFoundError
    when HTTP_UNPROCESSABLE_ENTITY_CODE
      UnprocessableEntityError
    else
      ApiError
    end
  end

  def api_requests_quota_reached?
    response.body.match?(API_REQUSTS_QUOTA_REACHED_MESSAGE)
  end
end